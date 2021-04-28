# Merging VCF files from multiple studies

## Concat VCF files from different chromsomes

```bash
bcftools concat chr1.vcf.gz chr2.vcf.gz -Oz -o output.vcf.gz
```

## Remvoe genotype probability (GP) fields from individual studies 
(this saves a lot of space and GP values are currently not used in our workflows)

```bash
bcftools annotate -x FORMAT/GP input.vcf.gz -Oz -o output.vcf.gz
```

## Index VCF files

```bash
bcftools index input.vcf.gz
```

## Merge VCF files across individuals

```bash
bcftools merge input1.vcf.gz input2.vcf.gz -Oz -o output.vcf.gz
```

## Remove any variants that contain missing GT values

```bash
bcftools view -e 'GT~"\."' input.vcf.gz -Oz -o output.vcf.gz
```

