### TO SETUP

## Install Latest Python & Node
1) Install latest python3 (via installing python3.exe x64-bit or npm)
2) Install latest node (minimum v18)
3) Install Playwright (pip install playwright or npm playwright)
4) Verify:
python3 -v 
node -v
npm -v
npx -v
![README-verifyInstallPythonNode.png](screenshots\README\README-verifyInstallPythonNode.png)

## Create and setup clean project / Python virtual environment
1) python -m pip install --upgrade pip
 or python.exe -m pip install --upgrade pip
2) pip install -r requirements.txt or python3 -m pip install -r requirements.txt
![README-pipinstallrequirements.png](screenshots\README\README-pipinstallrequirements.png)
3) rfbrowser init (do not connect to VPN/CDB network, use CMD not Powershell!)
![README-rfbrowserinit.png](screenshots\README\README-rfbrowserinit.png)
4) verify: rfbrowser --version (use CMD not bash or powershell!)
![README-rfbrowser--version.png](screenshots\README\README-rfbrowser--version.png)


## Set up Qase integration
5) pip install qase-robotframework
![README-pipinstallqase-robotframework.png](screenshots\README\README-pipinstallqase-robotframework.png)



## Run Robot Tests with Qase Reporting
Example (copy and run these commands)
- robot NGOS/TestCases/ngos-prepaid-reload.robot (refer this example!)
- robot NGOS/TestCases/ngos-addon.robot (OK)
- robot NGOS/TestCases/ngos-postpaid-billpayment.robot (not completed
- robot NGOS/TestCases/ngos-regression-npl-newuser-princialwithsup (Eve's test)


## specify your Qase project and run IDs dynamically
robot --listener "qase.robotframework.Listener;projectCode=DEMO;runId=123" tests/


## Run Robot test with Qase listener
- robot --listener qase.robotframework.Listener --include smoke tests/
- robot --listener qase_robotframework.listener QASE_PROJECT_CODE=DEMO QASE_RUN_NAME="Smoke Test" tests/
- --include smoke = run only tests tagged with smoke
- tests/ = path to your .robot test cases


## Create your first test file
tests/demo.robot