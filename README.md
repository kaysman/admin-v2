Deploy commands:
- flutter build web
- firebase init
- add this to firebase.json:

{
  "hosting": {
    "site": "lng-test-admin-app",
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ]
  }
}

- firebase deploy --only hosting:lng-test-admin-app

Live URL:
https://lng-test-admin-app.web.app

Test API URL:
https://lng-test-environment.as.r.appspot.com/api/v1
