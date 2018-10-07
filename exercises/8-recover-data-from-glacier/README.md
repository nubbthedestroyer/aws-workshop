# Exercise #8: Uploading to and recovering from Glacier

In this exercise, you will be creating a an Amazon Glacier Vault.  To complete the exercise, follow these steps:

### Create a Glacier Vault

1. Log into your AWS Console
1. Click the Services dropdown and click Amazon Glacier.
1. Click "Create Vault"
1. Enter a name in the "Vault Name" field, then click Next.
1. Leave "Do not enable notifications" selected. Click "Next Step"
1. Click Submit

### Upload a file to Glacier

1. Log into your Cloud9 IDE and open a new terminal.
1. enter the following to create a junk file that we can archive.

    ```bash
    dd if=/dev/zero of=./archive bs=1024 count=200000
    ```

1.  Use the following command to upload the file to Glacier

    ```bash
    aws glacier upload-archive --account-id - --vault-name <your-vault-name> --body ./archive
    ```

    * This will output some json.  One of the fields is "ArchiveId".  Save this, as we will need it to recover later.

1. Now lets start a job to recover the data.  Use the following command to start the recovery job.

    ```bash
    aws glacier initiate-job --account-id - --vault-name test --job-parameters '{"Type": "archive-retrieval", "ArchiveId": "<your-job-id>"}'
    ```
    
1. Now use this command to get the output of the recovery job.

    ```bash
    aws glacier get-job-output --account-id - --vault-name <your-vault-name> --job-id <jobId-from-previous-output> archive-recovered
    ```
    
    * You'll most likely get an error like the following
    
    ```
    An error occurred (InvalidParameterValueException) when calling the GetJobOutput operation: The job is not currently available for download:
    ```
    
    * This is expected.  Glacier can take a while to recover data from Vault due to to compromises its made to allow extremely cheap data storage.  Try again in 10 minutes and it should work.
    
    
Congratulations!!!  You Completed this exercise.