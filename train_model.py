# train_model.py
import joblib
from sklearn.datasets import load_diabetes
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression

# Load dataset
X, y = load_diabetes(return_X_y=True)

# Split and train
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
model = LinearRegression()
model.fit(X_train, y_train)

# Save the trained model
joblib.dump(model, "model.pkl")

print("✅ Model trained and saved as model.pkl")
