textgit
=======
An app that allows a user to send their favorite repositories, or important notifications from github to their friends via sms.

configuration
=============

In Networker.m, set the following constants to your twilio settings:

```objc
NSString *const TwilioSID           = @"123";
NSString *const TwilioAuth          = @"345";
NSString *const TwilioNumber        = @"2621235555";
```

todo (for CS657)
====
* add icon

improvements (future)
============
* Use twilio capability tokens (more secure)
* Use oauth for github api (more secure)
