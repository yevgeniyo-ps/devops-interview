# DevOps Troubleshooting Interview

Welcome to the DevOps troubleshooting challenge! This repository contains a Kubernetes application with several intentional issues that you need to identify and fix.

## WiFi Access

Connect to the **S1-Guest** network, fill out the questionnaire, and send your access request to yevgeniy.ovsyannikov@sentinelone.com

## Prerequisites

- [k3d](https://k3d.io/) installed
- [kubectl](https://kubernetes.io/docs/tasks/tools/) installed
- [colima or Docker Desktop]()
- Basic understanding of Kubernetes concepts

## Setup

1. Clone this repository:
```bash
git clone <repository-url>
cd devops-interview
```

2. Make the init script executable and run it:
```bash
chmod +x init.sh
./init.sh
```

This will create a k3d cluster with nginx ingress controller installed.

## Your Task

The deployment manifests contain multiple issues across different Kubernetes resources. Your goal is to:

1. **Deploy the application**:
   ```bash
   kubectl apply -f manifests/
   ```

2. **Identify and fix all issues** to get the application fully functional

3. **Verify success**: The application should be accessible at `http://localhost:8080` and display a success message


## Expected Outcome

When all issues are resolved:
- All pods should be in `Running` state with `READY` status
- Ingress should route traffic correctly
- Accessing `http://localhost:8080` should display a congratulations page

## Time Estimate

This challenge is designed to take approximately 30-40 minutes depending on experience level.

## Cleanup

To remove the cluster when done:
```bash
k3d cluster delete devops-interview
```

Good luck!
