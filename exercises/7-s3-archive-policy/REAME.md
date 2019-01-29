# Exercise #7: Setting up S3 archival policies

In this exercise, we will create an S3 Lifecycle Policy to archive files to Glacier based on age.  To do this, take the 
following steps:

### Add a Lifecycle Rule for Glacier 

1. Open the S3 console.
1. Click the bucket name of one of the buckets you created in one of the earlier exercises, or create a new one and click its name to open bucket config page.
1. Click the "Management" tab.
1. Click the "Lifecycle" sub-button if its not already selected. and then click on "Add lifecycle rule"
1. Give your rule a name you can identify.
1. In the filter section, type "data", and choose the prefix option.
1. The transitions screen offers a few useful capabilities.
    * Transitions for current object versions.  This is the transition age for existing active objects in the s3 bucket.
    * Transitions for previous versions of objects.  Suppose you want to keep objects in S3 for 3 months but you know you won't likely need to restore the objects if they make it past 2 weeks of QA.
    You could use this feature to save costs on object versioning, which can be especially useful if you are updating objects often.
1. Set a transition for current objects to 3 months and a transition for previous versions to 30 days.
1. Click through the rest of the screens, leaving everything at defaults, and click Save at the end.  We will create a different policy for expirations.

### Add a Lifecycle Rule for Expirations (delete)

1. In the Name and Scope screen set a name you'll be able to identify and in the filter box, enter "logs" and choose the prefix option.
1. Click next at the transitions screen.
1. The Expirations screen will let you set an expiration for your objects stored in S3.  This means that instead of archiving to Glacier,
you can elect to delete your objects automatically.  This can be useful for short term logging situations where retention is not a requirement.
1. Check Current Version and "Expire current version of object".
1. In the After field, type 95.
1. Check Clean up incomplete multi-part uploads and leave the default 7 days, then click Next.
1. Review your changes and click save.
