import hail as hl
import argparse

parser = argparse.ArgumentParser(description = "Convert genotype probabilities in bgen format to a VCF file with GT and DS fields", formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument("--prefix", help = "Prefix of the bgen/vcf file.")
args = parser.parse_args()

#set file names
bgen_file = args.prefix + ".bgen"
sample_file = args.prefix + ".samples"
vcf_file = args.prefix + ".vcf.bgz"

hl.init()
recode = {f"0{i}":f"{i}" for i in list(range(1, 10))}
print(recode)
hl.index_bgen(bgen_file, contig_recoding=recode)
data = hl.import_bgen(bgen_file, entry_fields=['GT', 'dosage'], sample_file=sample_file)
data2 = data.annotate_entries(DS = data.dosage)
data3 = data2.drop('dosage')
hl.export_vcf(data3, vcf_file)