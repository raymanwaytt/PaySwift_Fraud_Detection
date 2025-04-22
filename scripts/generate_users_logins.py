# This script generates 1K users and 10K logins, saving them to CSV files.

import pandas as pd
import numpy as np

dates = pd.date_range("2025-03-01", "2025-03-31", freq="h")
regions = ["Lagos", "Nairobi", "Cape Town"]

# Users (1K)
users_data = []
for i in range(1000):
    user_id = f"USR{100 + i}"
    age_days = np.random.randint(30, 365)
    avg_value = round(np.random.uniform(2000, 20000), 2)
    users_data.append([user_id, age_days, avg_value])
users_df = pd.DataFrame(users_data, columns=["user_id", "account_age_days", "avg_transaction_value"])
users_df.to_csv("data/users.csv", index=False)

# Logins (10K)
logins_data = []
for i, date in enumerate(np.random.choice(dates, 10000)):
    fails = np.random.randint(1, 3) if np.random.rand() < 0.2 else 0
    status = "failed" if fails > 0 else "success"
    logins_data.append([f"USR{np.random.randint(100, 999)}", pd.Timestamp(date), status, fails])
logins_df = pd.DataFrame(logins_data, columns=["user_id", "timestamp", "login_status", "failed_attempts"])
logins_df.to_csv("data/logins.csv", index=False)

print("Generated 1K users and 10K logins")