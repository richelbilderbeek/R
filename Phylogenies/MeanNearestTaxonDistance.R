# Example adapted from Steven Kembel, downloaded at http://www.inside-r.org/packages/cran/picante/docs/ses.mpd
library(ape)
library(picante)

data(phylocom)

# Show the phylogeny
plot(phylocom$phylo)

ses.mpd(phylocom$sample, cophenetic(phylocom$phylo),null.model="taxa.labels")

#         ntaxa  mpd.obs mpd.rand.mean mpd.rand.sd mpd.obs.rank    mpd.obs.z
# clump1      8 4.857143      8.324181   0.3207660          1.0 -10.80862276
# clump2a     8 6.000000      8.334048   0.3208481          1.0  -7.27462215
# clump2b     8 7.142857      8.316459   0.3320787          7.0  -3.53410891
# clump4      8 8.285714      8.301587   0.3438603        396.0  -0.04616124
# even        8 8.857143      8.330616   0.3112614        998.0   1.69158943
# random      8 8.428571      8.329401   0.3168456        540.5   0.31299348
#         mpd.obs.p runs
# clump1     0.0010  999
# clump2a    0.0010  999
# clump2b    0.0070  999
# clump4     0.3960  999
# even       0.9980  999
# random     0.5405  999

ses.mntd(phylocom$sample, cophenetic(phylocom$phylo),null.model="taxa.labels")

#         ntaxa mntd.obs mntd.rand.mean mntd.rand.sd mntd.obs.rank mntd.obs.z
# clump1      8        2       4.702703    0.6529206           1.0 -4.1394048
# clump2a     8        2       4.750501    0.6495912           1.0 -4.2342024
# clump2b     8        2       4.709459    0.6661423           1.0 -4.0673882
# clump4      8        2       4.732983    0.6503319           1.0 -4.2024434
# even        8        6       4.679930    0.6607521         996.5  1.9978297
# random      8        5       4.727728    0.6328451         641.0  0.4302353
#         mntd.obs.p runs
# clump1      0.0010  999
# clump2a     0.0010  999
# clump2b     0.0010  999
# clump4      0.0010  999
# even        0.9965  999
# random      0.6410  999