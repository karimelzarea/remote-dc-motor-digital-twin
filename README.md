# Remote DC Motor Speed & Position Control Digital Twin

ENME506 Project 6.2 — German International University

This repository contains the implementation of a software digital twin for a remotely controlled DC motor. The controller runs separately from the motor plant and communicates over TCP or UDP.

## Repository structure

```text
plant/          Motor equations and real-time plant server
controller/     Discrete PID and network controller client
net/            Shared protocol, TCP/UDP links, and impairment emulation
ui/             Live digital-twin dashboard
experiments/    Automated experiment runner
analysis/       Metrics and plot generation
docs/           Architecture notes and report material
config.yaml     Shared runtime configuration
```

## Setup

### 1. Prerequisites

- Python 3.11 or newer
- Git
- NumPy and Matplotlib

### 2. Clone and enter the repository

```bash
git clone https://github.com/karimelzarea/remote-dc-motor-digital-twin.git
cd remote-dc-motor-digital-twin
```

### 3. Create and activate a virtual environment

**macOS/Linux**

```bash
python3 -m venv .venv
source .venv/bin/activate
```

**Windows**

```powershell
py -3.11 -m venv .venv
.venv\Scripts\Activate.ps1
```

### 4. Install dependencies

```bash
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

### 5. Run the project

The implementation skeleton is still under development. When the plant and controller entry points are complete, run the plant and controller in separate terminals:

```bash
python plant/plant_server.py
python controller/controller_client.py
```

Select the transport and network settings in `config.yaml`.

## Shared interface

All network messages use newline-delimited JSON over TCP and one JSON datagram per UDP message.

```json
{"type":"cmd","seq":n,"t_send":t,"u":volts,"mode":"speed"}
{"type":"state","seq":n,"t_send":t,"omega":w,"theta":th,"i":i,"ack":m}
```

## Team board

- [Shared task board](https://github.com/users/karimelzarea/projects/1)
- Weekly sync: Friday, 18:00–18:30 Egypt time
- Stand-ups: every two days in the team group chat

## Team roles

| Member | Owns | Backs up |
|---|---|---|
| P1 | Plant and modelling | P2 |
| P2 | PID control | P1 |
| P3 | TCP transport | P4 |
| P4 | UDP and impairments | P3 |
| P5 | Digital-twin UI | P6 |
| P6 | Integration, QA, and submission | P5 |

## Milestones

| Milestone | Deadline |
|---|---|
| Kick-off and setup | Friday, 20 November 2026 |
| Plant model and local PID | Saturday, 28 November 2026 |
| Networked control loop | Saturday, 5 December 2026 |
| UI and network impairments | Saturday, 12 December 2026 |
| Experiments and analysis | Thursday, 17 December 2026 |
| Report and submission | Tuesday, 22 December 2026 |
