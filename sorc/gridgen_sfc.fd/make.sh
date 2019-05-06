#!/bin/sh --login

set -x

mac=$(hostname -f)

case $mac in

#---------------------------------------------------------------------------------
# BUILD PROGRAM ON WCOSS Phase 1/2.
#---------------------------------------------------------------------------------

g????.ncep.noaa.gov | t????.ncep.noaa.gov)

  module purge
  . /usrx/local/Modules/default/init/sh

  module load ics/16.0.3 
  module load ibmpe/1.3.0.12

  module load NetCDF/4.2/serial
  module use /nems/noscrub/emc.nemspara/soft/modulefiles
  module load esmf/7.1.0r

  export FCOMP="mpfort"
  export FFLAGS="-O0 -g -traceback -r8 -i4 -compiler intel -convert big_endian -check bounds -warn unused"

  make clean
  make
  rc=$?  ;;

#---------------------------------------------------------------------------------
# BUILD PROGRAM ON WCOSS CRAY.
#---------------------------------------------------------------------------------

llogin? | slogin?)

  module purge
  module load modules/3.2.6.7
  module load PrgEnv-intel/5.2.56
  module rm intel
  module load intel/16.3.210
  module load cray-mpich/7.2.0
  module load craype-haswell
  module load cray-netcdf

  module use /gpfs/hps3/emc/nems/noscrub/emc.nemspara/soft/modulefiles
  module load esmf/7.1.0r

  export FCOMP=ftn
  export FFLAGS="-O0 -g -r8 -i4 -convert big_endian -check bounds -craype-verbose"

  make clean
  make
  rc=$?  ;;

#---------------------------------------------------------------------------------
# BUILD PROGRAM ON THEIA.
#---------------------------------------------------------------------------------

tfe??)

  module purge

  module load intel/15.1.133
  module load impi/5.1.1.109
  module load netcdf/4.3.0
  module use /scratch4/NCEPDEV/nems/noscrub/emc.nemspara/soft/modulefiles
  module load esmf/7.1.0r

  export FCOMP=mpiifort
  export FFLAGS="-O0 -g -traceback -r8 -i4 -convert big_endian -check bounds -warn unused"

  make clean
  make
  rc=$?  ;;

#---------------------------------------------------------------------------------
# BUILD PROGRAM ON WCOSS-DELL.
#---------------------------------------------------------------------------------

m????.ncep.noaa.gov | v????.ncep.noaa.gov )

  module purge
  module use /usrx/local/dev/modulefiles

  module load ips/18.0.1.163
  module load impi/18.0.1
  module load NetCDF/4.5.0
  module load ESMF/7_1_0r

  export FCOMP=mpif90
  export FFLAGS="-O0 -g -traceback -r8 -i4 -convert big_endian -check bounds -warn unused"

  make clean
  make
  rc=$? ;;

esac

exit
