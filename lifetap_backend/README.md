# LifeTap Backend (Django + DRF + PostgreSQL)

Educational emergency-assistance / triage **prototype** backend. The triage
classifier is a transparent, rule-based system — **not** a clinically
validated diagnostic tool and **not** AI-based medical advice. All
"experts" and emergency contacts in this prototype should be demo/test
data only.

This matches Stage 2 (database) + Stage 3 (Django backend) + Stage 4
(rule-based triage engine) of the LifeTap project plan, structured as:

```
lifetap/            <- Django project settings
accounts/           <- Users, roles (PATIENT / EXPERT / ADMIN), auth
patients/           <- Patient profile
experts/            <- Expert directory + routing logic
emergencies/        <- Emergency case model, triage engine, main API
guides/             <- Fallback emergency guides
audit/              <- Audit log
dashboard/          <- Read-only admin statistics endpoints
```

---

## 1. Install prerequisites (Ubuntu)

```bash
sudo apt update
sudo apt install -y python3 python3-venv python3-pip postgresql postgresql-contrib

# Verify
python3 --version
psql --version
```

## 2. Create the PostgreSQL database

```bash
sudo -u postgres psql
```

Inside the `psql` prompt:

```sql
CREATE DATABASE lifetap_db;
CREATE USER lifetap_user WITH PASSWORD 'change_me';
ALTER ROLE lifetap_user SET client_encoding TO 'utf8';
ALTER ROLE lifetap_user SET default_transaction_isolation TO 'read committed';
ALTER ROLE lifetap_user SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE lifetap_db TO lifetap_user;
\q
```

## 3. Set up the Python project

```bash
cd lifetap_backend
python3 -m venv venv
source venv/bin/activate

pip install -r requirements.txt
```

## 4. Configure environment variables

```bash
cp .env.example .env
```

Edit `.env` and fill in the values (at minimum `DB_PASSWORD` and
`SECRET_KEY`). **Never commit `.env` to Git** — it's already in
`.gitignore`.

Generate a secret key:

```bash
python3 -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
```

## 5. Run migrations

```bash
python manage.py makemigrations accounts patients experts emergencies guides audit
python manage.py migrate
```

## 6. Create an admin superuser

```bash
python manage.py createsuperuser
```

## 7. (Optional) Load demo data

```bash
python manage.py loaddata fixtures/demo_experts.json fixtures/demo_guides.json
```

## 8. Run the dev server

```bash
python manage.py runserver 0.0.0.0:8000
```

- Django admin: http://127.0.0.1:8000/admin/
- API root: http://127.0.0.1:8000/api/

To test from a phone on the same Wi-Fi (Milestone: local LAN demo),
find your laptop's IP with `ip addr`, then point Flutter's base URL at
`http://<your-laptop-ip>:8000`.

---

## API overview

| Method | Endpoint                              | Purpose                          |
|--------|----------------------------------------|-----------------------------------|
| POST   | `/api/auth/register/`                  | Create account (role: patient)    |
| POST   | `/api/auth/login/`                     | Obtain JWT access/refresh tokens  |
| POST   | `/api/auth/refresh/`                   | Refresh JWT access token          |
| GET/PUT| `/api/patients/me/`                    | Patient's own profile             |
| POST   | `/api/emergencies/`                    | Report an emergency (core flow)   |
| GET    | `/api/emergencies/`                    | List own (or all, if admin) cases |
| GET    | `/api/emergencies/<id>/`               | Case detail                       |
| GET    | `/api/experts/`                        | List experts                      |
| GET    | `/api/experts/available/`              | List available experts            |
| GET    | `/api/guides/`                         | List fallback guides              |
| GET    | `/api/guides/<category>/`              | Guide steps for a category        |
| GET    | `/api/dashboard/statistics/`           | Admin: case counts by urgency     |
| GET    | `/api/dashboard/recent-cases/`         | Admin: recent case list           |

See each app's `views.py` for details. Test everything with Postman
**before** wiring up Flutter (Milestone 4 in the plan).

## Next steps (per the roadmap)

1. Test every endpoint above in Postman.
2. Only once APIs are verified, start the Flutter app and connect it.
3. Add GPS, then voice input, then polish auth/roles.

This backend intentionally does **not** call real phone numbers or
auto-dial anyone — the "expert" contact is just data the mobile app
displays with a "Call Expert" button that opens the phone dialer.
