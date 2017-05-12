#!/vin/sh
dbfile=`mktemp --suffix=.db`
logfile=`mktemp --suffix=.db`
cfgfile=`mktemp --suffix=.py`

db=sqlite_file:${dbfile}
log=sqlite_file:${logfile}
auth=
cond=$1
tag=$2
run=$3
file=$4
name=`echo $cond | sed 's/^GEM//g'`

cat <<% >$cfgfile

import FWCore.ParameterSet.Config as cms

process = cms.Process("ProcessOne")
process.load("CondCore.DBCommon.CondDBCommon_cfi")
process.CondDBCommon.DBParameters.authenticationPath = cms.untracked.string('${auth}' )
process.CondDBCommon.connect = cms.string('${db}')

process.source = cms.Source("EmptyIOVSource",
    timetype = cms.string('runnumber'),
    firstValue = cms.uint64(1),
    lastValue = cms.uint64(1),
    interval = cms.uint64(1)
)

process.PoolDBOutputService = cms.Service("PoolDBOutputService",
    process.CondDBCommon,
    logconnect = cms.untracked.string('${log}'),
    timetype = cms.untracked.string('runnumber'),
    toPut = cms.VPSet(cms.PSet(
        record = cms.string('${cond}Rcd'),
        tag = cms.string("${tag}")
    ))
)

process.WriteInDB = cms.EDAnalyzer("${cond}PopConAnalyzer",
    SinceAppendMode = cms.bool(True),
    record = cms.string('${cond}Rcd'),
    loggingOn = cms.untracked.bool(True),
   Source = cms.PSet(
        IOVRun = cms.untracked.uint32(${run})
    )
)

process.p = cms.Path(process.WriteInDB)
%

cmsRun $cfgfile && rm $cfgfile && echo "dbfile = ${dbfile}"

