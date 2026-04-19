# 🚦 Digital Traffic Signal System using Moore FSM with Emergency Override

## 📌 Overview
This project implements a 2-way traffic signal controller using a Moore Finite State Machine (FSM) in Verilog.  
The design ensures deterministic timing for signal transitions and supports emergency override for priority-based traffic control.

---

## ⚙️ Key Features
- Moore FSM with 4 states (S0–S3)
- Cycle-based timing:
  - Green = 10 cycles
  - Yellow = 4 cycles
- Emergency override:
  - `emergency_a` → Road A gets immediate green
  - `emergency_b` → Road B gets immediate green
  - If both active → Road A has priority
- Synchronous design (state changes only on clock edge)
- Clean separation of:
  - Sequential logic (state + counter)
  - Combinational logic (outputs)

---

## 🧩 State Encoding

| State | Code | Road A | Road B |
|------|------|--------|--------|
| S0 | 00 | Green | Red |
| S1 | 01 | Yellow | Red |
| S2 | 10 | Red | Green |
| S3 | 11 | Red | Yellow |

---

## 🔄 State Transitions

Normal operation:
S0 → S1 → S2 → S3 → S0

Timing:
- S0: 10 cycles
- S1: 4 cycles
- S2: 10 cycles
- S3: 4 cycles

Emergency behavior:
- From any state:
  - emergency_a = 1 → S0
  - emergency_b = 1 → S2
  - both = 1 → S0 (A priority)

---

## 🧪 Verification

Testbench covers:
- Reset initialization
- Normal FSM operation
- Emergency A override
- Emergency B override
- Simultaneous emergency handling

Expected behavior:
- State changes occur only at positive clock edge
- Counter resets on state transition
- Outputs depend only on state (Moore behavior)

---

## ▶️ Simulation

```bash
iverilog -o traffic.vvp src/traffic_controller.v src/traffic_controller_tb.v
vvp traffic.vvp
gtkwave traffic_controller.vcd

## 🧠 FSM State Diagram

![State Diagram](output/state_diagram.png)
