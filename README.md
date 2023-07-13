# Vending_machine
The Vending Machine designed is a Mealy type finite state machine where inputs are the money (of 5, 10 and 20 rupees) and the output is the change and the commodity of the vending machine (here cost is set as 30 rupees).
In this, 6 states are defined and according to the money that has been inserted the circuit provides the output of vend and change (if any).
•	First state is the IDLE state or the reset state (or 0 money entered state)
•	Second is the state when 5 rupees is added in the machine.
•	Third is when 10 rupees is added in the machine.
•	Fourth is when 15 rupees is added in the machine.
•	Fifth is when 20 rupees is added in the machine.
•	Last state is when 25 rupees is added in the machine.
Combinational circuit is designed in the FSM for providing the output whereas sequential circuit is designed for the machine to go in the next state at every positive edge of the clock.
And if any insertion of money exceeds 30 rupees the machine goes to the IDLE state with specific change provided as the output.
