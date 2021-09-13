# Mobile Wallet

#### Completed Tasks

- Designed the provided screens as in [the task description](https://github.com/AlexeiDrozdovSecurrency/MobileTest/blob/dev/README.md).
- User can go back by swiping from left to right.
- BloC state validation is used in all over the app for state management, therefore from lib/providers/ RegisterUserBloc is used for basic form validation and state managment among pages.
- For residence country both the approaches are added.
- 1. From lib/providers/ UserGeoLocationBloc is used to geocode user's current location coordinates to find current country and UserCountryDetermined is immidiately fired in order to fix text field and assigning to user details in RegisterUserBloc.
- 2. Following end-point from lib/constants/apiGetAllCountries = https://restcountries.eu/rest/v2 is used to fetch countries list and RegisterUserCountryListLoaded state is going to load countries immidiately in the popup for countries. Dio package is used to http requests.
- 3. For JSON modeling followng package [json_serializable](https://pub.dev/packages/json_serializable) is used.
- On pressing next button user is taken to lib/pages/make_selfie MakeSelfiePage, where user can go further to capture selfie with front camera in TakePicturePage. The page uses simple [camera](https://pub.dev/packages/camera) to capture image. The same bloc is used from the main to maintain user registration and in this case image file path is going to be added to the UserDetailsModel inside the RegisterUserBloc.
- Summery page will display the user details from the RegisterUserBloc available in it's own context.
- Since this is a mobile wallet appliation after the registration page it should go to the dashboard, but before that we should save user details in the remote server through a web service, which is not in this case so I have used the same bloc to take user to dashboard with disposing all previous pages but keeping the bloc to use the user details in drawer and furthermore in the dashboard.
- The code is structured in a simple possible way.
  | Main Folder | | |
  | ------------- |:-------------:| -----:|
  | lib | constants | files for static values |
  | | pages | all the screens that we would have in the app. Could have sub-folders. |
  | | providers | all the bussiness logic code, here in this case providers for each BloC (bussiness logic component) |
  | | style | app style and colors.
  | | utils | reusable utility functions in different BloCs.
  | | widgets | UI components that are reused in the pages/.
- For state management [BloC](https://pub.dev/packages/bloc) is used, which is simple and concise. You can see all the bussiness logic is segmented inside one folder lib/providers/.
- Both unit-tests and widget-tests are added in the lib/tests for basic feedback. I know this is not a comprehensive testing method, but surely we addopt the best practices in the real projects. For BloC we can use seperate way for testing which I skipped and kept the testing as simple as possible for now.
