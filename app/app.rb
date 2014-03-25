require 'sinatra'
require File.expand_path(File.dirname(__FILE__) +'/../lib/excel_merge')

post '/merge_excel/' do
  xls_template = params['template'][:tempfile]
  samples_csv  = params['manifest-details'][:tempfile]
  manifest     = ExcelMerge.merge_template_with_csv(xls_template, samples_csv)

  manifest.write "manifest.xls"
  # Use these headers when running as localhost.  Not needed behind nginx though...
  # response.headers['content_type'] = "application/vnd.ms-excel"
  # response.headers['Access-Control-Allow-Origin'] = '*'
  # response.headers['Access-Control-Allow-Methods'] = 'OPTIONS,GET,HEAD,POST,PUT,DELETE,TRACE,CONNECT'
  # response.headers['Access-Control-Request-Method'] = '*'
  # response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'

   send_file("manifest.xls", :type => "application/vnd.ms-excel", :filename => "manifest.xls", :stream => false)

   File.delete("./manifest.xls")
end

