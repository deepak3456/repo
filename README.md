# Amazon SageMaker XGBoost – End-to-End ML Training

## 📌 Project Overview
This project demonstrates an **end-to-end Machine Learning training workflow on Amazon SageMaker** using the **XGBoost algorithm**. The focus is on **real-world cloud ML engineering**, including IAM setup, data preparation, training orchestration, troubleshooting production issues, and cost-safe cleanup.

---

## 🏗️ Architecture Overview
**Flow:**
1. User triggers training from EC2 using AWS CLI / SageMaker SDK
2. Amazon SageMaker assumes an IAM execution role
3. Training data is read from Amazon S3
4. XGBoost model is trained on a managed EC2 instance (`ml.m5.large`)
5. Model artifacts are stored back in Amazon S3
6. Training job terminates (no running cost)

---

## 🔧 Tech Stack
- Amazon SageMaker
- XGBoost (built-in algorithm)
- Amazon S3
- AWS IAM
- AWS CLI
- SageMaker Python SDK (v2.x)
- EC2 (Ubuntu Linux)

---

## 📂 Data Preparation
- CSV format
- No header row
- Label as first column
- Numeric values only
- Directory-based S3 input

```
train/
 └── data.csv
```

---

## 🚀 Training
- SageMaker XGBoost (algorithm mode)
- Explicit TrainingInput with `content_type="text/csv"`
- Hyperparameters:
  - objective: binary:logistic
  - num_round: 10

---

## 🧪 Challenges Solved
- IAM permission & trust issues
- ECR image pull errors
- SDK version incompatibility
- XGBoost data validation errors
- Missing content-type configuration

---

## 💰 Cost-Safe Cleanup
- Deleted training jobs
- Verified no active endpoints
- Removed S3 model artifacts

---

## 🎯 Interview Summary
- Built an end-to-end ML training pipeline on Amazon SageMaker using XGBoost.
- Resolved production-grade IAM, SDK, ECR, and data-contract issues.

---

## ✅ Status
✔ Training completed  
✔ Resources cleaned up  
✔ Zero ongoing AWS cost  

**Author:** Deepak Ganesan
