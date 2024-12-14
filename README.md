# Analytics Manager (Mobile System Design)

The project demonstrates system design of a simple analytics manager for a mobile application.

The implementation is in **Swift**, demo uses **SwiftUI** and tested using **Swift Testing** framework.

## Functional Requirements

- The system provides an analytic service.
- The service is accessible from any location in code.
- The service receives analytics data from the application, as event.
- The service provides an input end point to receive an event.
- The service can accept multiple events.
- Each event must have a name and time.
- Each event can have additional associated data.
- The service provides option to set user id, session id and other metadata regarding the state of the application.
- The system supports different types of analytic services.
- Each service can specify the type of events it accepts.

## Non-Functional Requirements

- System should be scalable.
    - Adding/removing new analytic services should be easy.
    - Adding/removing new types of events should be easy.
- System should be testable.

## Solution

### Event

- An `AnalyticsEvent` is defined as an interface with desired properties.
- The interface can be implemented by different types of events.

### Service

- A protocol `AnalyticsService` is defined that provides methods to set metadata and send events.
- The protocol can be implemented by different types of analytic services.
- The protocol oriented approach enables scalability and testability.
- An `AnalyticsManager` class is defined that manages multiple analytic services at once.
- The manager can add/remove services and send events to all services.
- This class is implemented as a singleton, so that it can be accessed from any location in code.

### System Design

![Analytics Manager System Design](./assets/analytics-manager-basic-flow.drawio.svg)

### Class Diagram

![Analytics Manager Class Diagram](./assets/analytics-manager-basic-class-diagram.drawio.svg)
