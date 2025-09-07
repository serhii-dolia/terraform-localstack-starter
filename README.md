Localstack with terraform setup with one lambda function called `test`

1. Install aws cli. 
2. In AWS config (vim ~/.aws/config) add the profile `localstack`

```bash
[profile localstack]
region = ap-southeast-2
```


3. Start the Localstack
```bash
docker compose up
```

4. Prepare your lambda function
```bash
zip -j test.zip index.js
```

5. Apply the terraform setup to Localstack

```bash
terraform init
terraform apply --auto-approve
```

6. Check that the lambda is there:
```bash
aws --profile localstack --endpoint-url http://localhost:4566 lambda list-functions
```

7. Get the lambda URL:

```bash
aws --profile localstack --endpoint-url http://localhost:4566 \
lambda get-function-url-config --function-name test \
--query 'FunctionUrl' --output text
```

8. Take this URL, open it in the browser. You should see "Hello world"