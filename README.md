#  MediTriage – Smart Medical Triage & Hospital Routing MVP

MediTriage is a Flutter-based healthcare MVP that introduces **digital pre-hospital triage** to reduce OPD overcrowding and emergency delays. The app analyzes patient symptoms and duration using **rule-based clinical logic**, classifies medical severity, and intelligently routes patients to hospitals using real-time geospatial visualization.

This project demonstrates how a **pure software solution** can optimize hospital workflows, improve patient prioritization, and support faster medical decision-making without additional hardware.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

##  Problem Statement

Hospitals today face critical operational challenges:
- Overcrowded OPDs and long waiting times  
- No digital symptom-based pre-triage system  
- Manual OPD entry and appointment workflows  
- Poor routing of patients to appropriate hospitals  
- Emergency cases delayed due to lack of prioritization  

Patients with mild symptoms and critical emergencies often follow the same queue, leading to inefficiency, doctor overload, and delayed care.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

##  Solution Overview

MediTriage solves this by introducing a **triage-first digital flow**:

1. Patients enter symptoms and symptom duration  
2. A rule-based engine evaluates severity  
3. Severity is classified as **Mild / Moderate / Severe**  
4. Recommended action is generated instantly  
5. Nearby hospitals are discovered using **OpenStreetMap**  
6. Hospitals are displayed with **color-coded map markers**  
7. Patients confirm a hospital and receive an **instant appointment slip**

This ensures **right patient, right hospital, right time**.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

##  Key Features

- Symptom-based triage engine  
- Duration-aware severity classification  
- Rule-based medical decision logic  
- Real-time hospital discovery using OSM  
- Color-coded hospital mapping  
  - 🔴 Government / Free hospitals  
  - 🟡 Medical colleges / Institutes  
  - 🟢 Private hospitals  
- Live GPS-based current location marker  
- Interactive hospital selection  
- Instant appointment slip generation  
- Firebase-backed authentication and app flow  

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

##  Triage Logic (MVP Rules)

- Symptoms ≤ 2 days → Mild  
- Symptoms > 2 days → Moderate (Hospital visit recommended)  
- Symptoms > 5 days → Severe (Emergency care required)  
- High-risk symptoms (e.g. breathing difficulty) increase severity score  

This logic is **deterministic, explainable, and suitable for MVP validation**.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

##  Hospital Discovery & Mapping

- OpenStreetMap (OSM) used for map rendering  
- Overpass API used for hospital data retrieval  
- Hospitals are visually categorized using marker colors  
- Blue marker indicates patient’s current location  
- Tooltip-based hospital name display  

This avoids dependency on paid map services while ensuring scalability.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

##  Tech Stack

- **Flutter** – Cross-platform app development  
- **Firebase Authentication** – Anonymous session handling  
- **OpenStreetMap (OSM)** – Map rendering  
- **Overpass API** – Hospital data queries  
- **Geolocator** – Device GPS location  

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

##  MVP Scope

- End-to-end patient flow from symptom entry to booking  
- Rule-based severity classification (no ML dependency)  
- Real-time hospital visualization  
- Appointment confirmation and slip generation  
- Demo-ready UI and navigation  

This MVP is designed for **hackathon evaluation and real-world feasibility demonstration**.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

##  Future Enhancements

- Google Sign-In for patient accounts  
- Gmail API for hospital referral notifications  
- Google Calendar integration for OPD slot scheduling  
- Firebase Cloud Functions for backend automation  
- Analytics for patient flow and hospital load  
- ML Kit for advanced symptom intelligence  

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Project Structure# MediTriage-App
MediTriage is a Flutter-powered digital pre-triage system that applies rule-based clinical logic to patient symptoms and duration, classifies medical severity, and enables intelligent hospital routing via OpenStreetMap. It optimizes OPD workflows through real-time geospatial visualization and instant appointment slip generation.
