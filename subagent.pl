#! /usr/bin/perl

use NetSNMP::agent (':all');
use NetSNMP::ASN qw(ASN_COUNTER);

sub counter 																				{
  			my ($handler, $registration_info, $request_info, $requests) = @_;
  			my $request; 

  				for($request = $requests; $request; $request = $request->next()) 		{
    			my $oid = $request->getOID();
    				if ($request_info->getMode() == MODE_GET)						{
      					if ($oid == new NetSNMP::OID(".1.3.6.1.4.1.4171.40.1"))		{

        				$request->setValue(ASN_COUNTER, time);
      																				}
      					if ($oid >  new NetSNMP::OID(".1.3.6.1.4.1.4171.40.1")) 	{
       					
  
   
     					my $file = '/tmp/A1/counters.conf';   
     
     					my @end= split /[.]/,$oid;
     					my $value = @end[-1] -1 ;
					my @bitrate;
    					open(my $filehandler, '<:encoding(UTF-8)', $file);
     						for (;my $row = <$filehandler>;)						{ 
 							@bitrate = split(',', $row);
								if ($bitrate[0] == $value)							{
								$yt=$bitrate[1]*time;
 								$request->setValue(ASN_COUNTER, $yt);
																					}
								
							}

       					}
      				}
   				}
			}
  
my $agent = new NetSNMP::agent();
$agent->register("a1", ".1.3.6.1.4.1.4171.40", \&counter);

