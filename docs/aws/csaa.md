# AWS Certified Solutions Architect - Associate
( Brief summary off the course material because I read the FAQs )

## Useful links

The true guidance of what you need to do and what you need to know can be found [here](https://aws.amazon.com/certification/certified-solutions-architect-associate/).

I've used [this useful image](https://robertleggett.files.wordpress.com/2018/11/aws-solution-architect-associate.png) with [this blog post](http://jayendrapatil.com/aws-solutions-architect-associate-feb-2018-exam-learning-path/). It helped me out a lot during the exam! :D

### PDFs
* [AWS Cloud Best Practices](https://d0.awsstatic.com/whitepapers/AWS_Cloud_Best_Practices.pdf)
* [AWS Well-Architected Framework](https://d1.awsstatic.com/whitepapers/architecture/AWS_Well-Architected_Framework.pdf)
  * [Operational Excellence](https://d1.awsstatic.com/whitepapers/architecture/AWS-Operational-Excellence-Pillar.pdf)
  * [Security Pillar](https://d1.awsstatic.com/whitepapers/architecture/AWS-Security-Pillar.pdf)
  * [Reliability Pillar](https://d1.awsstatic.com/whitepapers/architecture/AWS-Reliability-Pillar.pdf)
  * [Performance Efficiency](https://d1.awsstatic.com/whitepapers/architecture/AWS-Performance-Efficiency-Pillar.pdf)
  * [Cost Optimization](https://d1.awsstatic.com/whitepapers/architecture/AWS-Cost-Optimization-Pillar.pdf)
* [Serverless Applications](https://d1.awsstatic.com/whitepapers/architecture/AWS-Serverless-Applications-Lens.pdf)
* [HPC Lens](https://d1.awsstatic.com/whitepapers/architecture/AWS-HPC-Lens.pdf)
* [IoT Lens](https://d1.awsstatic.com/whitepapers/architecture/AWS-IoT-Lens.pdf)

### FAQs
* [EC2](https://aws.amazon.com/ec2/faqs/)
* [S3](https://aws.amazon.com/s3/faqs/)
* [VPC](https://aws.amazon.com/vpc/faqs/)
* [Route 53](https://aws.amazon.com/route53/faqs/)
* [RDS](https://aws.amazon.com/rds/faqs/)
* [SQS](https://aws.amazon.com/sqs/faqs/)


# The AWS Well-Architected Framework

## The Pillars of the AWS Well-Architected Framework

| Pillar Name | Description |
| --------- | ------------------ |
| Operational Excellence|The ability to run and monitor systems to deliver business value and to continually improve supporting processes and procedures.
| Security | The ability to protect information, systems and assets while delivering business value through risk assessments and mitigation strategies.
| Reliability | The ability of a system to recover from infrastructure or service disruptions, dynamically acquire computing resources to meet demand, and mitigate disruptions such as misconfiguration or transient network issues.
| Performance Efficiency | The ability to use computing resources efficiently to meet system requirements, and to maintain that efficiency as demand changes and technologies evolved.
| Cost Optimization | The ability to run systems to deliver business value at the lowest price point.


## General Design Principles
* Stop Guessing your capacity needs
* Test systems at production scale
* Automate to make architectural experimentation easier
* Allow for evolutionary architectures
* Drive architectures using data
* Improve through game days


### Operational Excellence
* Perform operations as code
* Annotate documentation
* Make frequent, small, reversible changes
* Refine operations procedures frequently
* Anticipate failure
* Learn from all operational failures

### Security
* Implement a strong identity foundation
* Enable traceability
* Apply security at all layers
* Automate security best practices
* Protect data in transit and at rest
* Keep people away from data
* Prepare for security events

### Reliability
* Test recovery procedures
* Automatically recover from failure
* Scale horizontally to increase aggregate system availability
* Stop guessing capacity
* Manage change in automation

### Performance efficiency
* Democratize advanced technologies
* Go global in minutes
* Use serverless architectures
* Experiment more often
* Mechanical sympathy

### Cost optimization
* Adopt a consumption model
* Measure overall efficiency
* Stop spending money on data center operations
* Analyze and attribute expenditure
* Use managed and application level services to reduce cost of ownership
