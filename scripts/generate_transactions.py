import pandas as pd
import numpy as np

# Setup
dates = pd.date_range("2025-03-01", "2025-03-31", freq="h")
regions = ["Lagos", "Nairobi", "Cape Town"]
types = ["payment", "withdrawal", "deposit"]

# Generate 5K transactions
data = []
for i, date in enumerate(np.random.choice(dates, 10000)):
    amount = round(np.random.uniform(1000, 50000), 2)
    is_fraud = 1 if (amount > 30000 or pd.Timestamp(date).hour > 22) and np.random.rand() < 0.3 else 0
    data.append([f"TXN{i:05d}", f"USR{np.random.randint(100, 999)}", amount, date, 
                 np.random.choice(types), np.random.choice(regions), is_fraud])

# Save to CSV
df = pd.DataFrame(data, columns=["transaction_id", "user_id", "amount", "timestamp", "type", "region", "is_fraud"])
df.to_csv("data/transactions.csv", index=False)
print("Generated 10K transactions")