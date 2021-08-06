import hail as hl
hl.init()
recode = {f"{i}":f"chr{i}" for i in (list(range(1, 23)) + ['X', 'Y'])}
data = hl.import_vcf('/gpfs/hpc/projects/genomic_references/GEUVADIS/genotypes/GEUVADIS_GRCh38_filtered.vcf.gz', force = True, reference_genome='GRCh38', contig_recoding=recode)
data2 = data.annotate_entries(DS = data.GT.n_alt_alleles())
hl.export_vcf(data2, 'GEUVADIS_DS.vcf.bgz')
