# Controlling S3 Through the CLI

In this exercise, you will learn to control S3 through the AWS CLI.  The AWS CLI, or Command Line Interface, 
is a great way to make use of S3 for programmatic uses, like backups, migrations, deployments, or anything you 
can think of.  Tactically, we are going to do the following things.

1. Create an S3 bucket
1. upload a file
1. View file in the Console.
1. Download the file.
1. Sync a directory

So, without further or do, hop back into your Cloud9 IDE and lets get started.

1. Open Cloud9 IDE and go to the terminal window.
1. We want to create an S3 bucket that we can play with.  To do this, run the following command.  Be sure to 
chose a unique name, as S3 bucket names are global:

```bash
aws s3 mb "s3://<your-bucket-name>"
```

1. Now that we have our bucket, lets create a junk file and upload it to our bucket.

```bash
# create a junk file (20MB)
dd if=/dev/zero of=./test-file-1 bs=1024 count=20000

# upload to S3
s3 cp ./test-file-1 "s3://<your-bucket-name>"
```

1. Now lets view it in the Console.  Open your browser window and go to the S3 service.  You should see your new bucket
in the list.  Click it to open it and see your file there.

1. Now lets download the file.  Go back to your Cloud9 IDE and delete the local file

```bash
rm ./test-file-1
aws cp "s3://<your-bucket-name>/test-file-1" .

# List the current directory
ls -lah
```

1. Now lets do a directory sync.  The AWS CLI includes the ability to perform idempotent syncs of directories to S3. 
Run this command to create some test files and upload them.

```bash
# create 20 test files in a directory
mkdir -p dir2sync
for n in {1..20}; do dd if=/dev/zero of=./dir2sync/test-file-${n} bs=1024 count=10000; done

# Sync the directory to S3
aws s3 sync dir2sync/ s3://<your-bucket-name>/dir2sync

# list the contents of the directory you just synced.
aws s3 ls "s3://<your-bucket-name>/dir2sync/"
```

1. Now lets delete the files we uploaded.  Run the following:

```bash
# Remove the files
aws s3 rm "s3://<your-bucket-name>/dir2sync/"

# Make sure they are gone
aws s3 ls "s3://<your-bucket-name>/dir2sync/"

```

Congratz!!! You completed the exercise!  