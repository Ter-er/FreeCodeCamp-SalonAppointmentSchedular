# Salon Appointment Scheduler

## What this project is

I created a salon appointment scheduling system using PostgreSQL as part of the freeCodeCamp Relational Database curriculum.

The project includes a database with three main tables: `customers`, `services`, and `appointments`.

- The `customers` table stores unique customer information, including name and phone number.
- The `services` table lists all available salon services (e.g., haircut, coloring).
- The `appointments` table tracks which customer booked which service and at what time.

The system is powered by a Bash script (`salon.sh`) that interacts with the PostgreSQL database through the command line. Users can select a service, enter their information, and schedule an appointment — all via a terminal interface.

## What I learned and accomplished

- I practiced designing normalized database schemas with proper use of **primary** and **foreign keys** to maintain data integrity.
- I wrote SQL scripts to create and populate the necessary tables, ensuring they enforce uniqueness and support meaningful relationships.
- I created a **Bash script** that interacts with users and dynamically queries and inserts data into the database using **psql** commands.
- I implemented logic to handle returning vs. new customers, and ensured services are only booked if they exist in the database.
- I practiced **command-line database interaction**, using `psql` flags, SQL queries, and conditional Bash scripting.
- I completed the freeCodeCamp requirement to build a working command-line appointment scheduler that integrates Bash with PostgreSQL.

This project strengthened my confidence in combining **shell scripting** with **SQL**, as well as using PostgreSQL to build real-world, interactive tools.

---

Feel free to explore the `salon.sh` script and the database structure to see how everything ties together!
