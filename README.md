# Sleep-Tracer
An iOS app that analyzes user's Respiratory HealthKit data to detect the possibility of sleeping disorder, and recommend clinics nearby.
For product requirements, software architecture, development plan, QA test plan, etc., access to ❕❕ [Sleep Tracer Wiki](https://github.com/tatsuyamoriguchi/Sleep-Tracer/wiki)❕❕.


# Welcome to the Sleep-Tracer wiki!
Sleep Tracer is an iOS app that monitors your respiratory and heart rates along with other health and environment data, analyzes the possibility of sleeping disorder such as Sleep Apnea, and suggests to consult with nearby specialists.

* Detect the possibility of a user’s sleep disorder symptom with Apple Watch pairing with iOS devices
* Educates users about sleep apnea and other sleeping issues
* Give users health care options nearby for possible sleeping disorder and other symptoms
* Promote clinics, therapists, institutions, medication, and medical equipments
* HealthKit, FHIR data access, watchOS, CloudKit or Firebase, Push Notificaiton, Core Locaiton, MapKit, Apple Maps Points of Interest or Google Map API to get nearby clinics, Core Bluetooth to connect with a thermometer and other deivices as options, Charts, Weather API, Core Data, etc.

[1. Product Requirements](https://github.com/tatsuyamoriguchi/Sleep-Tracer/wiki/1.-Product-Requirements)

[2. HealthKit and HIPAA Compliance](https://github.com/tatsuyamoriguchi/Sleep-Tracer/wiki/2.-HealthKit-and-HIPAA-Compliance)

[3. UI Design Prototype](https://github.com/tatsuyamoriguchi/Sleep-Tracer/wiki/3.-UI-Design-Prototype)

[4. Software Architecture, Modularization, Code Quality](https://github.com/tatsuyamoriguchi/Sleep-Tracer/wiki/4.-Software-Architecture,-Modularization,-Code-Quality)

[5. iOS App Development Plan](https://github.com/tatsuyamoriguchi/Sleep-Tracer/wiki/5.-iOS-App-Development-Plan)

[6. QA Test Plan](https://github.com/tatsuyamoriguchi/Sleep-Tracer/wiki/6.-QA-Test-Plan)




## Product Concept
1. To provide a handy and easy to use tool to detect the possibility of a user’s sleep disorder symptom.
2. To educate users about sleep apnea and other sleeping issues
3. To give users health care options nearby for possible sleeping disorder and other symptoms
4. To promote clinics and institutions with Sleep Tracer(Ad revenue)
5. Implement Web 3.0 to give tokens to users who participated product trials. Give token asset value to their sleep data. Sleep assist or medical equipment manufacturers can purchase these sleep data by NFT. Sleep Tracer charges % of the transactions. This won’t reduce the manufacture’s trial budget. Trial users receive data compensation subtracted by Sleep Tracer fee(%).

## Environment:

MacBook Pro mid-2012

MacOS Catalina 10.15.7

Xcode 12.4

Swift ver 5

## iOS Framework:

iOS

Combine

MVVM

SwiftUI

HealthKit

watchOS

watchKit

Core Motion

Core Bluetooth

CloudKit/Firebase

REST API/GraphQL

Core Location

MapKit

Core Data

## Screen shot on April 11, 2022
Accessing HealthKit respiratory rate, and changes the font color depending on the respiratory rate ranges, 1-10 blue (possibility of sleep apnea) 10-19 normal, 20 or higher red (possibility of lung issue)



https://user-images.githubusercontent.com/25876806/162888566-cbac80e0-a614-4629-83d6-d773dc657d60.mp4

