# AWS.config(
# 	:access_key_id => 'AKIAI7IZAUCE4Q6RZNRQ',#ENV['AWS_ACCESS_KEY_ID'],
# 	:secret_access_key => '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' #ENV['AWS_SECRET_ACCESS_KEY']
# )

Aws.config.update({
  region: 'us-west-2',
  credentials: Aws::Credentials.new('AKIAI7IZAUCE4Q6RZNRQ', 'IkUlS4/iIDuY8LZPD/JT3PD+KVdTXGUPh12oRoe1'),
})

Aws.use_bundled_cert!
