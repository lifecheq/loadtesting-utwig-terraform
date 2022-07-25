PWD           := $(shell pwd)
TERRAFORM_IMG := hashicorp/terraform:1.1.9
PREAMBLE      := docker run --rm -i -t \
					--env HEROKU_EMAIL \
					--env HEROKU_API_KEY \
					-v $(PWD)/terraform:/terraform \
					-v "$(PWD)/.terraform":/.terraform/ \
					-w /terraform

shell:
	$(PREAMBLE) --entrypoint sh $(TERRAFORM_IMG)

init:
	$(PREAMBLE) $(TERRAFORM_IMG) init -backend-config="conn_str=${DATABASE_URL}"

output:
	$(PREAMBLE) $(TERRAFORM_IMG) output -json

refresh:
	$(PREAMBLE) $(TERRAFORM_IMG) apply -refresh-only

apply:
	$(PREAMBLE) $(TERRAFORM_IMG) apply

destroy:
	$(PREAMBLE) $(TERRAFORM_IMG) destroy

fmt:
	$(PREAMBLE) $(TERRAFORM_IMG) fmt -recursive
