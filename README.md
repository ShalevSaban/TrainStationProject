# TrainStationProject

The system describes the movement of trains between different stations,
allocation of workers between different stations and railway routes and shows passenger statistics between different destinations.
The purpose of the system:
To optimize the train traffic (preventing delays), adjusting the number of passengers to the train route / wagons, according to demand.


General description:

Train station has a name,adress and platforms.Every platform has a platform number.
Route has route number(starts with 100,+100 for opposite route number),origin train station,destination train station,day and scheduled time for departure.
Actual route has route number,train number date,time of departure and number of passengers.
Each Train is made of 5 wagons and has it's own train number(starts from 1000) and type (Electric/Steam/Diesel).
Wagon has wagon number(starts with 5001),train number, type of wagon(One floor/Two floor/ Accessible to the disabled/Reserved seats) and capacity.
Ticket of type "Regular" starts with ticket numer 9000,ticket of type "Student"
starts with 9200,type "Pensioner" starts with 9400 and type "Disabled" starts with 9600.Everey ticket has it's own price depends on the type of the ticket and the route.
On each train there are employees that divided into conductors and train drivers.The employees has id number,name and date of birth.
In addition,the train driver has years of experience and the conductor has the number of tickets he checked.
Crew has route number and employee id.
Stopover has train station name and route number.




