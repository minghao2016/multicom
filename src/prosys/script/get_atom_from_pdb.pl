#!/usr/bin/perl -w
##################################################################################################
#given a pdb file
#extract atom records from the pdb file for the file
#requirements: pdb file must be unziped. 
#output: atom records 
#Copied and modified from prosys/database/get_atom.pl
#Author: Jianlin Cheng, 4/21/2005 
#################################################################################################

##############standard Amino Acids (3 letter <-> 1 letter)#######################################
%amino=();
$amino{"ALA"} = 'A';
$amino{"CYS"} = 'C';
$amino{"ASP"} = 'D';
$amino{"GLU"} = 'E';
$amino{"PHE"} = 'F';
$amino{"GLY"} = 'G';
$amino{"HIS"} = 'H';
$amino{"ILE"} = 'I';
$amino{"LYS"} = 'K';
$amino{"LEU"} = 'L';
$amino{"MET"} = 'M';
$amino{"ASN"} = 'N';
$amino{"PRO"} = 'P';
$amino{"GLN"} = 'Q';
$amino{"ARG"} = 'R';
$amino{"SER"} = 'S';
$amino{"THR"} = 'T';
$amino{"VAL"} = 'V';
$amino{"TRP"} = 'W';
$amino{"TYR"} = 'Y';
###################################################################################################

#parse parameters
if (@ARGV != 2)
{
	die "Need two parameters: pdb file, atom_file\n"
}

$pdb_file =  shift @ARGV;
-f $pdb_file || die "pdb file doesn't exist.\n"; 
$atom_file =  shift @ARGV;

###############read pdb files########################################
if (! open(PDB, "$pdb_file"))
{
	`rm $tmp_file`; 
	die "fail to open unzip pdb file:$tmp_file.\n";
}
@content = <PDB>;
close PDB;
##########################################################################

###########################Extract Information from ATOM RECORD###########
#Extract all ATOMS RECORDS
@records = ();
$multi_model = 0;
foreach $text(@content)
{
	#handle multiple model (only use model 1)
	if ($text =~ /^MODEL\s+/)
	{
		$multi_model = 1;
	}
	if ($text =~ /^ENDMDL/)
	{
		if ($multi_model == 1)
		{
			print "multiple model, take model 1\n";
			last;
		}
	}
	if ($text =~ /^ATOM\s+/)
	{
		$cid = substr($text, 21, 1); 
		if ($cid eq " ")
		{
			$cid = 'A'; 
		}
		push @records, $text; 
	}
}

#very unefficient algorithm to extract atoms

@atoms = (); 

$atom_ind = 1; 
$res_ind = 1; 

$pre_ser = -1;
$pre_insertion = -1; 

$atom_num = 0; 
$total_num = @records; 
foreach $text(@records)
{
	$atom_num++; 

	#get residue name
	$res = substr($text, 17, 3); 

	#get chain id
	$cid = substr($text, 21, 1); 
	if ($cid eq " ")
	{
		$cid = 'A'; 
	}

	#get atom name
	$atom_name = substr($text, 12, 4);

	$is_ca = 0;
	if ($atom_name =~ /CA/)
	{
		$is_ca = 1; 
	}

	#get the residue serial number
	$ser = substr($text, 22, 4);

	#get insertion code
	$insertion_code = substr($text, 26, 1); 

	#conver to one letter
	$res = uc($res); 
	
	#check the residue length (3-letter or 1-letter)
	$res =~ s/\s+//g;
	if (length($res) == 3)
	{
		if (exists($amino{$res}) )
		{
			$aa = $amino{$res}; 
		}
		else
		{
			$aa = "X"; 
		}
		}
	else
	{
		$aa = $res;
	}

	#set chain id to " "
	$text = substr($text,0, 21) . " " . substr($text, 22);


	#check if the information match
	if ( $total_num != $atom_num && ($pre_ser == -1 || $ser == $pre_ser && $insertion_code eq $pre_insertion) )
	{
		#print "total:$total_num, cur: $atom_num\n";
		push @temp_atoms, $text; 
		if ($pre_ser == -1)
		{
			$pre_ser = $ser;
			$pre_insertion = $insertion_code; 
		}
	}
	else
	{
		#output the atoms for previous residues

		foreach $new_line (@temp_atoms)
		{
			$atom_line = $new_line;
			#replace the old atom id (7-11) with new index.
			$atom_ord = sprintf("%5d", $atom_ind);
			$atom_line = substr($atom_line, 0, 6) . $atom_ord . substr($atom_line, 11); 

			#replace residue index with new index
			$res_ord = sprintf("%4d", $res_ind);
			$atom_line = substr($atom_line, 0, 22) . $res_ord . substr($atom_line, 26);

			#remove the insertion code if necessary
			$atom_line = substr($atom_line, 0, 26) . " " . substr($atom_line, 27); 

			push @atoms, $atom_line; 

			$atom_ind++;
		}
		$res_ind++; 

		
		@temp_atoms = ();	
		push @temp_atoms, $text; 
		$pre_ser = $ser;
		$pre_insertion = $insertion_code; 
	}
}

if (@temp_atoms > 0)
{

	foreach $new_line (@temp_atoms)
	{
		$atom_line = $new_line;
		#replace the old atom id (7-11) with new index.
		$atom_ord = sprintf("%5d", $atom_ind);
		$atom_line = substr($atom_line, 0, 6) . $atom_ord . substr($atom_line, 11); 

		#replace residue index with new index
		$res_ord = sprintf("%4d", $res_ind);
		$atom_line = substr($atom_line, 0, 22) . $res_ord . substr($atom_line, 26);

		#remove the insertion code if necessary
		$atom_line = substr($atom_line, 0, 26) . " " . substr($atom_line, 27); 

		push @atoms, $atom_line; 

		$atom_ind++;
	}
}
	
#output
open(ATOM, ">$atom_file") || die "can't create atom file.\n";
print ATOM join("", @atoms);
print ATOM "END\n";
close ATOM;

