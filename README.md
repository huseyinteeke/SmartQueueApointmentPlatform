# Smart Queue & Appointment Platform (QueueFlow)

A web-based platform for service businesses such as salons, barbers, repair shops and service centers to manage
**appointments** and **virtual queues**. Customers can choose services and employees, book available time slots,
join a queue remotely, and track their appointment history.

> BBF 302E Database Systems – Term Project, Fall 2026

## Features

- **Authentication & roles** – register / login / logout with role-based access (Admin, Business Owner, Employee, Customer, Guest)
- **Businesses & services** – owners manage their business, services (duration, price) and staff
- **Employee–service matching** – each employee is assigned the services they can perform
- **Working schedules** – weekly working hours per employee
- **Appointment booking** – pick a service, an employee and a date, see free slots and book; reschedule or cancel
- **Virtual queue** – join a daily queue, get a ticket number, see your position and estimated waiting time
- **Staff tools** – daily agenda, appointment status updates, call the next customer in the queue
- **Reviews** – rate completed appointments (1–5 stars)
- **Reports** – popular services, revenue, employee utilization, average waiting times

## Tech Stack

| Layer | Technology |
|---|---|
| Database | MySQL 8 (InnoDB) |
| DB driver | mysql-connector-python – **raw SQL only, no ORM** |
| Backend | Flask (Python) with Blueprints |
| Frontend | Jinja2 templates + Bootstrap 5 |
| Auth | Flask sessions + Werkzeug password hashing |
| Sample data | Python + Faker |

## Database Overview

| # | Table | Description |
|---|---|---|
| 1 | `users` | All accounts and their roles |
| 2 | `businesses` | Salons, repair shops, service centers |
| 3 | `services` | Services offered by a business |
| 4 | `employee_services` | Which employee can perform which service (M:N) |
| 5 | `employees` | Staff profile of a user at a business (1:1 with users) |
| 6 | `employee_schedules` | Weekly working hours |
| 7 | `appointments` | Booked time slots |
| 8 | `reviews` | Rating of a completed appointment (1:1 with appointments) |
| 9 | `queues` | Daily virtual queues of a business |
| 10 | `queue_entries` | Customers waiting in a queue |

## Team

| Member | Role | Tables |
|---|---|---|
| [Member 1] (Team Leader) | Authentication, users & businesses | users, businesses |
| [Member 2] | Service catalog & employee–service matching | services, employee_services |
| [Member 3] | Employees & working schedules | employees, employee_schedules |
| [Member 4] | Appointments, booking & reviews | appointments, reviews |
| [Member 5] | Virtual queues & queue statistics | queues, queue_entries |

## Project Structure (planned)

```
app/
  __init__.py          # create_app(), blueprint registration
  db.py                # MySQL connection helpers
  auth/                # login, register, roles
  businesses/
  services/
  employees/
  appointments/
  queues/
  templates/           # Jinja2 templates (Bootstrap 5)
  static/
sql/
  schema.sql           # CREATE TABLE statements
  seed.py              # sample data generator (Faker)
requirements.txt
run.py
```

## Setup (will be finalized during development)

```bash
git clone https://github.com/huseyinteeke/SmartQueueApointmentPlatform.git
cd SmartQueueApointmentPlatform
python -m venv venv
venv\Scripts\activate          # Windows  (macOS/Linux: source venv/bin/activate)
pip install -r requirements.txt
```

1. Create a MySQL database and run `sql/schema.sql`.
2. Copy `.env.example` to `.env` and fill in your MySQL credentials.
3. Populate sample data: `python sql/seed.py`
4. Start the app: `flask --app run run --debug`

## Milestones

- [ ] **M1** – Project proposal & group formation (16.10.2026)
- [ ] **M2** – ER diagram & data model design (15.11.2026)
- [ ] **M3** – Database implementation & Flask app skeleton (11.12.2026)
- [ ] **M4** – CRUD, complex queries, authentication, demo & documentation (22.12.2026)

## Contribution Rules

- Everyone commits **with their own GitHub account**, regularly.
- Work on a feature branch (e.g. `feature/appointments`) and open a pull request to `main`.
- Write clear commit messages (e.g. `Add service create form and INSERT query`).
- Never commit `.env` or database passwords.
