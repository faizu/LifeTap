#!/usr/bin/env bash
# LifeTap API smoke test — run this AFTER the server is up
# (python manage.py runserver) and demo fixtures are loaded.
#
# Usage: bash test_api.sh
set -e
BASE="http://127.0.0.1:8000/api"

echo "== 1. Register a demo patient =="
curl -s -X POST "$BASE/auth/register/" \
  -H "Content-Type: application/json" \
  -d '{"username":"demo_patient","email":"demo@example.com","password":"DemoPass123!"}' | tee /tmp/register.json
echo -e "\n"

echo "== 2. Login =="
curl -s -X POST "$BASE/auth/login/" \
  -H "Content-Type: application/json" \
  -d '{"username":"demo_patient","password":"DemoPass123!"}' > /tmp/login.json
cat /tmp/login.json
ACCESS=$(python3 -c "import json; print(json.load(open('/tmp/login.json'))['access'])")
echo -e "\nAccess token acquired.\n"

AUTH="Authorization: Bearer $ACCESS"

echo "== 3. Check /me/ (role) =="
curl -s "$BASE/auth/me/" -H "$AUTH"
echo -e "\n"

echo "== 4. Get/update patient profile =="
curl -s -X PUT "$BASE/patients/me/" -H "$AUTH" -H "Content-Type: application/json" \
  -d '{"name":"Demo Patient","age":45,"gender":"MALE","blood_group":"O+","medical_history":"","emergency_contact_name":"Ahmed","emergency_contact_phone":"9876543210","phone":"9998887777"}'
echo -e "\n"

echo "== 5. List experts (should show demo fixtures) =="
curl -s "$BASE/experts/" -H "$AUTH"
echo -e "\n"

echo "== 6. Report an emergency — HIGH urgency, expert SHOULD be found =="
curl -s -X POST "$BASE/emergencies/" -H "$AUTH" -H "Content-Type: application/json" \
  -d '{"symptoms":"severe chest pain and difficulty breathing","latitude":12.9716,"longitude":77.5946}'
echo -e "\n"

echo "== 7. Report an emergency — LOW urgency, minor injury =="
curl -s -X POST "$BASE/emergencies/" -H "$AUTH" -H "Content-Type: application/json" \
  -d '{"symptoms":"minor cut on finger, mild pain","latitude":12.9716,"longitude":77.5946}'
echo -e "\n"

echo "== 8. Report an emergency where the only matching specialist is unavailable =="
echo "     (cardiology expert in fixtures is available=false, should still route to nearest available)"
curl -s -X POST "$BASE/emergencies/" -H "$AUTH" -H "Content-Type: application/json" \
  -d '{"symptoms":"unconscious, not breathing","latitude":12.9352,"longitude":77.6245}'
echo -e "\n"

echo "== 9. List my cases =="
curl -s "$BASE/emergencies/" -H "$AUTH"
echo -e "\n"

echo "== 10. Fallback guide by category =="
curl -s "$BASE/guides/BURN/" -H "$AUTH"
echo -e "\n"

echo "== 11. Dashboard as non-admin (should be 403) =="
curl -s -o /dev/null -w "HTTP %{http_code}\n" "$BASE/dashboard/statistics/" -H "$AUTH"

echo -e "\nDone. Review the JSON above — urgency levels, expert assignment,"
echo "and fallback guides should all match what you'd expect from the"
echo "rules in emergencies/triage.py."
