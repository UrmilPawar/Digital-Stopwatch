# Digital-Stopwatch
This project involves designing of stopwatch using assembly language.
This is a simple assembly language program that performs the following tasks:
1.	Defining default number of hours, minutes, seconds.
2.	Contains procedures for:
•	Clearing the screen (clear)
•	Printing 2 digit numbers (print)
•	Moving to a new line (newline)
•	Inserting a 1-second delay (delay)
•	Printing a colon (seprator)
•	Inserting spaces in the output screen (space)
•	Reading 2-digit decimal values (read)
3.	During the execution:
•	The code initially calls for the read procedure to read hours, minutes, and seconds.
•	Then it enters a loop to display a countdown timer:
•	Clearing the previous screen.
•	With the help of newline and space procedures, positioning the output in middle for better view.
•	Printing hours, minutes, and seconds by inserting a colon between them.
•	Inserting Delay for 1 second.
•	Decrements the time values and calls the loop again and again  until the values of all mintues, seconds and hours becomes zero.
