# LifeTap

LifeTap is an educational emergency-assistance prototype developed as a student project using **Flutter**, **Django REST Framework**, and **PostgreSQL**.

The project demonstrates how a mobile application can collect emergency information, perform transparent rule-based triage, display appropriate emergency guidance, and connect users with available experts.

> **IMPORTANT:** LifeTap is an educational prototype. It is not a clinically validated medical system and must not be used as a replacement for professional medical advice, diagnosis, treatment, or emergency services.

---

## Features

- Emergency case reporting
- Rule-based emergency triage
- Patient management
- Expert directory
- Expert routing
- Emergency guides
- User authentication
- JWT-based authentication
- Audit logging
- Flutter mobile application
- Django REST API
- PostgreSQL database
- Demo/fixture data
- Android emulator support
- Flutter Web support

---

# Project Structure

```text
LifeTap/
│
├── lifetap_app/                  # Flutter application
│   ├── android/                  # Android platform files
│   ├── lib/                      # Flutter source code
│   ├── test/                     # Flutter tests
│   ├── pubspec.yaml              # Flutter dependencies
│   └── README.md                 # Flutter-specific documentation
│
├── lifetap_backend/              # Django REST Framework backend
│   ├── lifetap/                  # Django project configuration
│   ├── accounts/                 # Authentication and user roles
│   ├── patients/                 # Patient management
│   ├── experts/                  # Expert directory and routing
│   ├── emergencies/              # Emergency cases and triage
│   ├── guides/                   # Emergency guides
│   ├── audit/                    # Audit logging
│   ├── dashboard/                # Dashboard/statistics APIs
│   ├── fixtures/                 # Demo data
│   ├── requirements.txt          # Python dependencies
│   ├── .env.example              # Environment configuration template
│   └── README.md                 # Backend-specific documentation
│
├── docs/                         # Additional documentation
│
├── scripts/                      # Optional setup/helper scripts
│   ├── ubuntu/
│   └── windows/
│
├── .gitignore                    # Files excluded from Git
└── README.md                     # Main project documentation
Technology Stack
Frontend
Flutter
Dart
Material Design
Backend
Python
Django
Django REST Framework
Simple JWT
django-cors-headers
Database
PostgreSQL
Development Platforms

LifeTap is intended to support development on:

Ubuntu/Linux
Windows
Android Emulator
Android physical devices
Web browser through Flutter Web
Requirements

Before running LifeTap, students should have the following software installed.

Required Software
1. Git

Git is required to download the project and manage the source code.

Verify:

git --version
2. Python

Python is required for the Django backend.

Verify on Linux/Ubuntu:

python3 --version

Verify on Windows:

python --version
3. Flutter

Flutter is required for the mobile application.

Verify:

flutter --version
flutter doctor

Flutter should be configured for Android development when using an Android emulator or Android device.

4. Android Studio

Android Studio is recommended for:

Android SDK
Android SDK Platform Tools
Android Emulator
Android Virtual Device (AVD)

Verify Android Debug Bridge:

adb --version
5. Java JDK

Android development requires a compatible Java JDK.

The development environment used for this project uses Java 17.

Verify:

java -version

Flutter can be configured to use a specific JDK:

flutter config --jdk-dir="PATH_TO_JDK"
6. PostgreSQL

PostgreSQL is required by the LifeTap backend.

Verify:

psql --version
Important: Existing Software Is Fine

Students may already have some or all of the required software installed.

They do not need to reinstall software that is already correctly installed.

For example, if Git, Python, Flutter, Android Studio, Java, or PostgreSQL is already installed, students should first verify it using the appropriate version command and continue with the setup.

Only missing or incorrectly configured components need to be installed or fixed.

Getting the Project

Clone the repository:

git clone https://github.com/faizu/LifeTap.git

Enter the project directory:

cd LifeTap
Backend Setup

The Django backend is located inside:

lifetap_backend/
Linux / Ubuntu

Enter the backend directory:

cd lifetap_backend

Create a Python virtual environment:

python3 -m venv venv

Activate it:

source venv/bin/activate

Install the required packages:

pip install -r requirements.txt
Windows

Open Command Prompt or PowerShell.

Enter the backend directory:

cd lifetap_backend

Create a virtual environment:

python -m venv venv

Activate it:

venv\Scripts\activate

Install the required packages:

pip install -r requirements.txt
PostgreSQL Database Setup

Create a PostgreSQL database for LifeTap.

Example:

CREATE DATABASE lifetap_db;
CREATE USER lifetap_user WITH PASSWORD 'change_me';

ALTER ROLE lifetap_user SET client_encoding TO 'utf8';
ALTER ROLE lifetap_user SET default_transaction_isolation TO 'read committed';
ALTER ROLE lifetap_user SET timezone TO 'UTC';

GRANT ALL PRIVILEGES ON DATABASE lifetap_db TO lifetap_user;

Use an appropriate password for the local development environment.

Environment Configuration

Inside the backend directory, create the environment file from the example.

Linux/Ubuntu:

cp .env.example .env

Windows:

copy .env.example .env

Edit .env and configure the database settings.

Example:

SECRET_KEY=replace-with-a-generated-secret-key
DEBUG=True
ALLOWED_HOSTS=127.0.0.1,localhost

DB_NAME=lifetap_db
DB_USER=lifetap_user
DB_PASSWORD=your_database_password
DB_HOST=localhost
DB_PORT=5432
Important

Never commit .env to Git.

The .env file contains private configuration.

The repository contains:

.env.example

instead of the real .env.

Generate Django Secret Key

Generate a new Django secret key:

python3 -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"

On Windows, if python3 is not available, use:

python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"

Copy the generated value into:

SECRET_KEY=

inside .env.

Run Django Migrations

From the lifetap_backend directory:

python manage.py makemigrations
python manage.py migrate
Create Django Administrator

Create an administrator account:

python manage.py createsuperuser

Follow the prompts.

Load Demo Data

LifeTap contains demonstration data for experts and emergency guides.

Run:

python manage.py loaddata fixtures/demo_experts.json fixtures/demo_guides.json
Check Django Configuration

Run:

python manage.py check

A successful setup should report:

System check identified no issues
Start the Backend

Run:

python manage.py runserver 0.0.0.0:8000

The backend will normally be available at:

http://127.0.0.1:8000/

Django administration:

http://127.0.0.1:8000/admin/

API root:

http://127.0.0.1:8000/api/

Keep the backend terminal running while using the Flutter application with the backend.

Flutter Setup

Open a second terminal.

Go to the Flutter application:

cd LifeTap/lifetap_app

Install Flutter dependencies:

flutter pub get

Check available devices:

flutter devices
Running LifeTap on Android Emulator

Start an Android emulator using Android Studio or the command line.

List available Flutter emulators:

flutter emulators

Launch an emulator:

flutter emulators --launch <emulator_id>

For example:

flutter emulators --launch Pixel_7

The emulator name may be different on another computer.

Check that Flutter detects the emulator:

flutter devices

You should see an Android device.

Run the application:

flutter run

If multiple devices are available, specify the Android emulator:

flutter run -d <device_id>
Running LifeTap in Google Chrome

Flutter Web can also be used for the current LifeTap prototype.

Check available devices:

flutter devices

Run:

flutter run -d chrome

The application will open in Google Chrome.

Running on a Physical Android Device

Enable:

Developer Options
USB Debugging

on the Android phone.

Connect the phone to the computer using USB.

Check:

adb devices

Then:

flutter devices

If the Android device appears, run:

flutter run
Android Folder

The following folder is part of the Flutter project:

lifetap_app/android/

It contains Android-specific project configuration required to build and run the Flutter application on Android.

Do not delete the Android folder.

Students do not need to create this folder manually after cloning the repository because it is already included in Git.

However, some files are intentionally excluded from Git because they contain computer-specific configuration.

For example:

lifetap_app/android/local.properties

is not committed because it contains the local Android SDK path.

Each student's Flutter/Android environment creates or configures the appropriate local settings for their own computer.

Android SDK

Students should have the Android SDK installed through Android Studio.

The exact SDK installation path may differ between computers.

Therefore, the project does not store machine-specific SDK paths in Git.

Students can check their Android/Flutter configuration with:

flutter doctor

If Flutter reports Android configuration problems, follow the instructions displayed by:

flutter doctor
Flutter Dependencies

Flutter dependencies are defined in:

lifetap_app/pubspec.yaml

Students should run:

flutter pub get

after cloning the project.

Do not manually copy the .dart_tool directory or build files from another computer.

These files are generated locally.

Backend Dependencies

Python dependencies are defined in:

lifetap_backend/requirements.txt

Students should install them using:

pip install -r requirements.txt

The Python virtual environment itself is not stored in Git.

Each student creates their own virtual environment.

API Endpoints

The current backend provides APIs including:

Method	Endpoint	Purpose
POST	/api/auth/register/	Create patient account
POST	/api/auth/login/	Obtain JWT tokens
POST	/api/auth/refresh/	Refresh JWT token
GET/PUT	/api/patients/me/	Patient profile
POST	/api/emergencies/	Report emergency
GET	/api/emergencies/	List emergency cases
GET	/api/emergencies/<id>/	Emergency case details
GET	/api/experts/	List experts
GET	/api/experts/available/	Available experts
GET	/api/guides/	Emergency guides
GET	/api/guides/<category>/	Guide for category
GET	/api/dashboard/statistics/	Dashboard statistics
GET	/api/dashboard/recent-cases/	Recent cases
Current Project Stage
Flutter Application

The current Flutter application contains:

Splash screen
Login screen
Registration screen
Home screen
Emergency reporting screen
Result screen
Expert directory
Emergency guides
My emergency cases
Profile screen
Mock/demo data
Android project configuration
Django Backend

The current Django backend contains:

User accounts
Patient management
Expert management
Emergency cases
Rule-based triage
Emergency guides
Audit logging
Dashboard APIs
JWT authentication
PostgreSQL configuration
Demo fixtures
Current Flutter Demo

The current Flutter stage uses mock data.

The Flutter application can be run independently for the UI demonstration.

The current demo does not yet represent the complete production integration between Flutter and the Django backend.

Project Limitation

LifeTap is an educational prototype.

The triage system uses transparent, rule-based keyword matching.

It is not:

A clinically validated diagnostic system
A replacement for a doctor
A replacement for emergency services
A medical AI system
A system for real emergency decision-making

Demo experts, emergency contacts, and fixture data are intended for educational and testing purposes only.

Development Workflow

After cloning the repository, students should normally use two terminals.

Terminal 1 — Backend

Linux/Ubuntu:

cd LifeTap/lifetap_backend
source venv/bin/activate
python manage.py runserver 0.0.0.0:8000

Windows:

cd LifeTap\lifetap_backend
venv\Scripts\activate
python manage.py runserver 0.0.0.0:8000
Terminal 2 — Flutter
cd LifeTap/lifetap_app
flutter pub get
flutter run

For Chrome:

flutter run -d chrome
Checking the Project
Backend
cd lifetap_backend
python manage.py check
Flutter
cd lifetap_app
flutter analyze
Flutter Tests
flutter test
Useful Commands

Check Flutter:

flutter doctor

Check Flutter devices:

flutter devices

List Android emulators:

flutter emulators

Check Android devices:

adb devices

Install Flutter packages:

flutter pub get

Check Django:

python manage.py check

Run Django:

python manage.py runserver 0.0.0.0:8000
Git Workflow for Students

Before starting work:

git pull

Check the current status:

git status

Review changes:

git diff

Stage changes:

git add .

Commit changes:

git commit -m "Describe your changes"

Push changes:

git push
Additional Documentation

Backend-specific documentation:

lifetap_backend/README.md

Flutter-specific documentation:

lifetap_app/README.md

Additional project documentation:

docs/
Repository

GitHub repository:

https://github.com/faizu/LifeTap
Educational Use

LifeTap is developed for educational and academic demonstration purposes.

Students can study, modify, test, and extend the project as part of their academic work.

LifeTap

Flutter + Django REST Framework + PostgreSQL

Educational Emergency-Assistance Prototype
```
