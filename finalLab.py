# 匯入套件
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import warnings

from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, precision_score, recall_score
from sklearn.preprocessing import StandardScaler
from xgboost import XGBClassifier
from catboost import CatBoostClassifier

warnings.filterwarnings("ignore")

# 讀取資料
df = pd.read_csv("data.csv")
df = df.iloc[:, 1:]
print(f"Shape of df: {df.shape}")
print(df.head())

# LabelEncoding
df["diabetes"] = [0 if x == "neg" else 1 for x in df["diabetes"].values]

# 分割訓練集以及驗證集
X = df.drop("diabetes", axis=1)
y = df["diabetes"]
X_train, X_test, y_train, y_test = train_test_split(
    X, y, train_size=0.8, random_state=123
    )
print(f"Shape of X_train: {X_train.shape}")
print(f"Shape of y_train: {y_train.shape}")
print(f"Shape of X_test: {X_test.shape}")
print(f"Shape of y_test: {y_test.shape}")

# predict without data preprocessing
def display_result(y_true, y_pred):
    print(f"ACC(test): {accuracy_score(y_true, y_pred): .4f}")
    print(f"Precision(test): {precision_score(y_true, y_pred): .4f}")
    print(f"Recall(test): {recall_score(y_true, y_pred): .4f}")

DT = DecisionTreeClassifier()
model_dt = DT.fit(X_train, y_train)
y_hat_dt = model_dt.predict(X_test)
display_result(y_true=y_test, y_pred=y_hat_dt)

print("-" * 20)

XGB = XGBClassifier()
model_xgb = XGB.fit(X_train, y_train)
y_hat_xgb = model_xgb.predict(X_test)
display_result(y_true=y_test, y_pred=y_hat_xgb)

print("-" * 20)

CAT = CatBoostClassifier(verbose=0)
model_cat = CAT.fit(X_train, y_train)
y_hat_cat = model_cat.predict(X_test)
display_result(y_true=y_test, y_pred=y_hat_cat)

print("-" * 20)

RF = RandomForestClassifier()
model_rf = RF.fit(X_train, y_train)
y_hat_rf = model_rf.predict(X_test)
display_result(y_true=y_test, y_pred=y_hat_rf)

# standardization
scaler = StandardScaler()
X_train.iloc[:, :] = scaler.fit_transform(X_train)
X_test.iloc[:, :] = scaler.transform(X_test)

# heatmap
c_matrix = df.corr()
plt.figure(figsize=(10, 10))
sns.heatmap(c_matrix, annot=True)
plt.xticks(rotation=45)
plt.title("HeatMap", size=16)
plt.show()

# drop pregnant
try:
    X_train = X_train.drop("pregnant", axis=1)
    X_test = X_test.drop("pregnant", axis=1)
except:
    print("Already drop.")

# predict with data preprocessing
DT = DecisionTreeClassifier()
model_dt = DT.fit(X_train, y_train)
y_hat_dt = model_dt.predict(X_test)
display_result(y_true=y_test, y_pred=y_hat_dt)

print("-" * 20)

XGB = XGBClassifier()
model_xgb = XGB.fit(X_train, y_train)
y_hat_xgb = model_xgb.predict(X_test)
display_result(y_true=y_test, y_pred=y_hat_xgb)

print("-" * 20)

CAT = CatBoostClassifier(verbose=0)
model_cat = CAT.fit(X_train, y_train)
y_hat_cat = model_cat.predict(X_test)
display_result(y_true=y_test, y_pred=y_hat_cat)

print("-" * 20)

RF = RandomForestClassifier()
model_rf = RF.fit(X_train, y_train)
y_hat_rf = model_rf.predict(X_test)
display_result(y_true=y_test, y_pred=y_hat_rf)