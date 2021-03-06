#!/usr/bin/perl -w

$test_script_dir= '/home/jhou4/tools/multicom/installation/MULTICOM_test_codes';
$test_out_dir= '/home/jhou4/tools/multicom/test_out';

$num = @ARGV;
if($num ==0)
{
	$proc_num = 1;
}elsif($num ==1)
{
	$proc_num = $ARGV[0];
	if($proc_num > 5)
	{
		die "5 maximum jobs are reccommended for parallel testing\n";
	}
}else{
	die "usage: perl test_multicom_all_parallel.pl <optional: numebr of parallel jobs>";
}



-d $test_script_dir || die "$test_script_dir does not exist.\n";

-d $test_out_dir || `mkdir $test_out_dir`;

chdir($test_script_dir);
opendir(DIR,"$test_script_dir") || die "Failed to open directory $test_script_dir\n";
@input_files = readdir(DIR);
closedir(DIR);

@running_files = ();
foreach $file (sort @input_files)
{
	if($file eq '.' or $file eq '..' or substr($file,length($file)-3) ne '.sh')
	{
		next;
	}
	$file_path = "$test_script_dir/$file";
	push @running_files,$file_path;
}
	
foreach $file_path (sort @running_files)
{
	## check the running jobs
	$min_elaps=0;
	while(1)
	{
		opendir(DIR,"$test_out_dir") || die "Failed to open directory $test_out_dir\n";
		@out_files = readdir(DIR);
		closedir(DIR);
		
		$running_num = 1;
		foreach $check_file (sort @out_files)
		{
			if($check_file eq '.' or $check_file eq '..' or substr($check_file,length($check_file)-8) ne '.running')
			{
				next;
			}
			$running_num++;
		}
		if($running_num<=$proc_num)
		{
			last;
		}
		sleep(60);
		$min_elaps++;
		if($min_elaps > 60)
		{
			last; # move to next;
		}
	}
	
	print "run test $file_path\n";
	system("sh $file_path > /dev/null 2>&1 &");
	$remain_jobs = @running_files-$running_num;
	print "Current running jobs ($running_num), remaining jobs ($remain_jobs)\n\n";
	sleep(5);
}


