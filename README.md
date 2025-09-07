Localstack with terraform setup with one lambda function called `test`

0. Install aws cli. 
0. In AWS config (vim ~/.aws/config) add the profile `localstack`

```bash
[profile localstack]
region = ap-southeast-2
```


1. Start the Localstack
```bash
docker compose up
```

2. Prepare your lambda function
```bash
zip -j test.zip index.js
```

3. Apply the terraform setup to Localstack

```bash
terraform init
terraform apply --auto-approve
```

4. Check that the lambda is there:
```bash
aws --profile localstack --endpoint-url http://localhost:4566 lambda list-functions
```

5. Get the lambda URL:

```bash
aws --profile localstack --endpoint-url http://localhost:4566 \
lambda get-function-url-config --function-name test \
--query 'FunctionUrl' --output text
```

6. Take this URL, open it in the browser. You should see "Hello world"