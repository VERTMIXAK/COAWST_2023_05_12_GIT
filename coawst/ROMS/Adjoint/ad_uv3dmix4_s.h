      SUBROUTINE ad_uv3dmix4 (ng, tile)
!
!svn $Id: ad_uv3dmix4_s.h 1054 2021-03-06 19:47:12Z arango $
!************************************************** Hernan G. Arango ***
!  Copyright (c) 2002-2021 The ROMS/TOMS Group       Andrew M. Moore   !
!    Licensed under a MIT/X style license                              !
!    See License_ROMS.txt                                              !
!***********************************************************************
!                                                                      !
!  This subroutine computes adjoint biharmonic mixing  of momentum,    !
!  along constant S-surfaces, from the horizontal divergence of the    !
!  stress tensor.  A  transverse isotropy  is assumed so the stress    !
!  tensor is split into vertical and horizontal subtensors.            !
!                                                                      !
!  Reference:                                                          !
!                                                                      !
!      Wajsowicz, R.C, 1993: A consistent formulation of the           !
!         anisotropic stress tensor for use in models of the           !
!         large-scale ocean circulation, JCP, 105, 333-338.            !
!                                                                      !
!      Sadourny, R. and K. Maynard, 1997: Formulations of              !
!         lateral diffusion in geophysical fluid dynamics              !
!         models, In Numerical Methods of Atmospheric and              !
!         Oceanic Modelling. Lin, Laprise, and Ritchie,                !
!         Eds., NRC Research Press, 547-556.                           !
!                                                                      !
!      Griffies, S.M. and R.W. Hallberg, 2000: Biharmonic              !
!         friction with a Smagorinsky-like viscosity for               !
!         use in large-scale eddy-permitting ocean models,             !
!         Monthly Weather Rev., 128, 8, 2935-2946.                     !
!                                                                      !
!  Basic state variables required:  visc4, u, v, Hz.                   !
!                                                                      !
!***********************************************************************
!
      USE mod_param
      USE mod_ncparam
      USE mod_coupling
!!#ifdef DIAGNOSTICS_UV
!!    USE mod_diags
!!#endif
      USE mod_grid
      USE mod_mixing
      USE mod_ocean
      USE mod_stepping
!
!  Imported variable declarations.
!
      integer, intent(in) :: ng, tile
!
!  Local variable declarations.
!
      character (len=*), parameter :: MyFile =                          &
     &  __FILE__
!
#include "tile.h"
!
#ifdef PROFILE
      CALL wclock_on (ng, iADM, 32, __LINE__, MyFile)
#endif
      CALL ad_uv3dmix4_tile (ng, tile,                                  &
     &                       LBi, UBi, LBj, UBj,                        &
     &                       IminS, ImaxS, JminS, JmaxS,                &
     &                       nrhs(ng), nnew(ng),                        &
#ifdef MASKING
     &                       GRID(ng) % pmask,                          &
#endif
     &                       GRID(ng) % Hz,                             &
     &                       GRID(ng) % ad_Hz,                          &
     &                       GRID(ng) % om_p,                           &
     &                       GRID(ng) % om_r,                           &
     &                       GRID(ng) % on_p,                           &
     &                       GRID(ng) % on_r,                           &
     &                       GRID(ng) % pm,                             &
     &                       GRID(ng) % pmon_p,                         &
     &                       GRID(ng) % pmon_r,                         &
     &                       GRID(ng) % pn,                             &
     &                       GRID(ng) % pnom_p,                         &
     &                       GRID(ng) % pnom_r,                         &
     &                       MIXING(ng) % visc4_p,                      &
     &                       MIXING(ng) % visc4_r,                      &
!!#ifdef DIAGNOSTICS_UV
!!   &                       DIAGS(ng) % DiaRUfrc,                      &
!!   &                       DIAGS(ng) % DiaRVfrc,                      &
!!   &                       DIAGS(ng) % DiaU3wrk,                      &
!!   &                       DIAGS(ng) % DiaV3wrk,                      &
!!#endif
     &                       OCEAN(ng) % u,                             &
     &                       OCEAN(ng) % v,                             &
     &                       COUPLING(ng) % ad_rufrc,                   &
     &                       COUPLING(ng) % ad_rvfrc,                   &
     &                       OCEAN(ng) % ad_u,                          &
     &                       OCEAN(ng) % ad_v)
#ifdef PROFILE
      CALL wclock_off (ng, iADM, 32, __LINE__, MyFile)
#endif
!
      RETURN
      END SUBROUTINE ad_uv3dmix4

!
!***********************************************************************
      SUBROUTINE ad_uv3dmix4_tile (ng, tile,                            &
     &                             LBi, UBi, LBj, UBj,                  &
     &                             IminS, ImaxS, JminS, JmaxS,          &
     &                             nrhs, nnew,                          &
#ifdef MASKING
     &                             pmask,                               &
#endif
     &                             Hz, ad_Hz,                           &
     &                             om_p, om_r, on_p, on_r,              &
     &                             pm, pmon_p, pmon_r,                  &
     &                             pn, pnom_p, pnom_r,                  &
     &                             visc4_p, visc4_r,                    &
!!#ifdef DIAGNOSTICS_UV
!!   &                             DiaRUfrc, DiaRVfrc,                  &
!!   &                             DiaU3wrk, DiaV3wrk,                  &
!!#endif
     &                             u, v,                                &
     &                             ad_rufrc, ad_rvfrc, ad_u, ad_v)
!***********************************************************************
!
      USE mod_param
      USE mod_scalars
!
!  Imported variable declarations.
!
      integer, intent(in) :: ng, tile
      integer, intent(in) :: LBi, UBi, LBj, UBj
      integer, intent(in) :: IminS, ImaxS, JminS, JmaxS
      integer, intent(in) :: nrhs, nnew

#ifdef ASSUMED_SHAPE
# ifdef MASKING
      real(r8), intent(in) :: pmask(LBi:,LBj:)
# endif
      real(r8), intent(in) :: Hz(LBi:,LBj:,:)
      real(r8), intent(in) :: om_p(LBi:,LBj:)
      real(r8), intent(in) :: om_r(LBi:,LBj:)
      real(r8), intent(in) :: on_p(LBi:,LBj:)
      real(r8), intent(in) :: on_r(LBi:,LBj:)
      real(r8), intent(in) :: pm(LBi:,LBj:)
      real(r8), intent(in) :: pmon_p(LBi:,LBj:)
      real(r8), intent(in) :: pmon_r(LBi:,LBj:)
      real(r8), intent(in) :: pn(LBi:,LBj:)
      real(r8), intent(in) :: pnom_p(LBi:,LBj:)
      real(r8), intent(in) :: pnom_r(LBi:,LBj:)
      real(r8), intent(in) :: visc4_p(LBi:,LBj:)
      real(r8), intent(in) :: visc4_r(LBi:,LBj:)

      real(r8), intent(in) :: u(LBi:,LBj:,:,:)
      real(r8), intent(in) :: v(LBi:,LBj:,:,:)

!!# ifdef DIAGNOSTICS_UV
!!    real(r8), intent(inout) :: DiaRUfrc(LBi:,LBj:,:,:)
!!    real(r8), intent(inout) :: DiaRVfrc(LBi:,LBj:,:,:)
!!    real(r8), intent(inout) :: DiaU3wrk(LBi:,LBj:,:,:)
!!    real(r8), intent(inout) :: DiaV3wrk(LBi:,LBj:,:,:)
!!# endif

      real(r8), intent(inout) :: ad_Hz(LBi:,LBj:,:)
      real(r8), intent(inout) :: ad_rufrc(LBi:,LBj:)
      real(r8), intent(inout) :: ad_rvfrc(LBi:,LBj:)
      real(r8), intent(inout) :: ad_u(LBi:,LBj:,:,:)
      real(r8), intent(inout) :: ad_v(LBi:,LBj:,:,:)

#else

# ifdef MASKING
      real(r8), intent(in) :: pmask(LBi:UBi,LBj:UBj)
# endif
      real(r8), intent(in) :: Hz(LBi:UBi,LBj:UBj,N(ng))
      real(r8), intent(in) :: om_p(LBi:UBi,LBj:UBj)
      real(r8), intent(in) :: om_r(LBi:UBi,LBj:UBj)
      real(r8), intent(in) :: on_p(LBi:UBi,LBj:UBj)
      real(r8), intent(in) :: on_r(LBi:UBi,LBj:UBj)
      real(r8), intent(in) :: pm(LBi:UBi,LBj:UBj)
      real(r8), intent(in) :: pmon_p(LBi:UBi,LBj:UBj)
      real(r8), intent(in) :: pmon_r(LBi:UBi,LBj:UBj)
      real(r8), intent(in) :: pn(LBi:UBi,LBj:UBj)
      real(r8), intent(in) :: pnom_p(LBi:UBi,LBj:UBj)
      real(r8), intent(in) :: pnom_r(LBi:UBi,LBj:UBj)
      real(r8), intent(in) :: visc4_p(LBi:UBi,LBj:UBj)
      real(r8), intent(in) :: visc4_r(LBi:UBi,LBj:UBj)

      real(r8), intent(inout) :: u(LBi:UBi,LBj:UBj,N(ng),2)
      real(r8), intent(inout) :: v(LBi:UBi,LBj:UBj,N(ng),2)

!!# ifdef DIAGNOSTICS_UV
!!    real(r8), intent(inout) :: DiaRUfrc(LBi:UBi,LBj:UBj,3,NDM2d-1)
!!    real(r8), intent(inout) :: DiaRVfrc(LBi:UBi,LBj:UBj,3,NDM2d-1)
!!    real(r8), intent(inout) :: DiaU3wrk(LBi:UBi,LBj:UBj,N(ng),NDM3d)
!!    real(r8), intent(inout) :: DiaV3wrk(LBi:UBi,LBj:UBj,N(ng),NDM3d)
!!# endif

      real(r8), intent(inout) :: ad_Hz(LBi:UBi,LBj:UBj,N(ng))
      real(r8), intent(inout) :: ad_rufrc(LBi:UBi,LBj:UBj)
      real(r8), intent(inout) :: ad_rvfrc(LBi:UBi,LBj:UBj)
      real(r8), intent(inout) :: ad_u(LBi:UBi,LBj:UBj,N(ng),2)
      real(r8), intent(inout) :: ad_v(LBi:UBi,LBj:UBj,N(ng),2)
#endif
!
!  Local variable declarations.
!
      integer :: IminU, IminV, ImaxU, ImaxV
      integer :: JminU, JminV, JmaxU, JmaxV
      integer :: i, j, k

      real(r8) :: cff, cff1, cff2
      real(r8) :: ad_cff, ad_cff1, ad_cff2
      real(r8) :: adfac, adfac1, adfac2, adfac3, adfac4

      real(r8), dimension(IminS:ImaxS,JminS:JmaxS) :: LapU
      real(r8), dimension(IminS:ImaxS,JminS:JmaxS) :: LapV
      real(r8), dimension(IminS:ImaxS,JminS:JmaxS) :: UFe
      real(r8), dimension(IminS:ImaxS,JminS:JmaxS) :: VFe
      real(r8), dimension(IminS:ImaxS,JminS:JmaxS) :: UFx
      real(r8), dimension(IminS:ImaxS,JminS:JmaxS) :: VFx

      real(r8), dimension(IminS:ImaxS,JminS:JmaxS) :: ad_LapU
      real(r8), dimension(IminS:ImaxS,JminS:JmaxS) :: ad_LapV
      real(r8), dimension(IminS:ImaxS,JminS:JmaxS) :: ad_UFe
      real(r8), dimension(IminS:ImaxS,JminS:JmaxS) :: ad_VFe
      real(r8), dimension(IminS:ImaxS,JminS:JmaxS) :: ad_UFx
      real(r8), dimension(IminS:ImaxS,JminS:JmaxS) :: ad_VFx

#include "set_bounds.h"
!
!-----------------------------------------------------------------------
!  Initialize adjoint private variables.
!-----------------------------------------------------------------------
!
      ad_cff=0.0_r8
      ad_cff1=0.0_r8
      ad_cff2=0.0_r8

      ad_LapU(IminS:ImaxS,JminS:JmaxS)=0.0_r8
      ad_LapV(IminS:ImaxS,JminS:JmaxS)=0.0_r8

      ad_UFe(IminS:ImaxS,JminS:JmaxS)=0.0_r8
      ad_VFe(IminS:ImaxS,JminS:JmaxS)=0.0_r8
      ad_UFx(IminS:ImaxS,JminS:JmaxS)=0.0_r8
      ad_VFx(IminS:ImaxS,JminS:JmaxS)=0.0_r8
!
!-----------------------------------------------------------------------
!  Compute adjoint horizontal biharmonic viscosity along constant
!  S-surfaces. The biharmonic operator is computed by applying the
!  harmonic operator twice.
!-----------------------------------------------------------------------
!
!  Set local I- and J-ranges.
!
      IF (EWperiodic(ng)) THEN
        IminU=Istr-1
        ImaxU=Iend+1
        IminV=Istr-1
        ImaxV=Iend+1
      ELSE
        IminU=MAX(2,IstrU-1)
        ImaxU=MIN(Iend+1,Lm(ng))
        IminV=MAX(1,Istr-1)
        ImaxV=MIN(Iend+1,Lm(ng))
      END IF
      IF (NSperiodic(ng)) THEN
        JminU=Jstr-1
        JmaxU=Jend+1
        JminV=Jstr-1
        JmaxV=Jend+1
      ELSE
        JminU=MAX(1,Jstr-1)
        JmaxU=MIN(Jend+1,Mm(ng))
        JminV=MAX(2,JstrV-1)
        JmaxV=MIN(Jend+1,Mm(ng))
      END IF
!
!  Computed required BASIC STATE flux-components of the horizontal
!  divergence of the stress tensor in XI- and ETA-directions.
!
      K_LOOP : DO k=1,N(ng)
        DO j=-1+JminV,JmaxV
          DO i=-1+IminU,ImaxU
            cff=visc4_r(i,j)*0.5_r8*                                    &
     &          (pmon_r(i,j)*                                           &
     &           ((pn(i  ,j)+pn(i+1,j))*u(i+1,j,k,nrhs)-                &
     &            (pn(i-1,j)+pn(i  ,j))*u(i  ,j,k,nrhs))-               &
     &           pnom_r(i,j)*                                           &
     &           ((pm(i,j  )+pm(i,j+1))*v(i,j+1,k,nrhs)-                &
     &            (pm(i,j-1)+pm(i,j  ))*v(i,j  ,k,nrhs)))
            UFx(i,j)=on_r(i,j)*on_r(i,j)*cff
            VFe(i,j)=om_r(i,j)*om_r(i,j)*cff
          END DO
        END DO
        DO j=JminU,JmaxU+1
          DO i=IminV,ImaxV+1
            cff=visc4_p(i,j)*0.5_r8*                                    &
     &          (pmon_p(i,j)*                                           &
     &           ((pn(i  ,j-1)+pn(i  ,j))*v(i  ,j,k,nrhs)-              &
     &            (pn(i-1,j-1)+pn(i-1,j))*v(i-1,j,k,nrhs))+             &
     &           pnom_p(i,j)*                                           &
     &           ((pm(i-1,j  )+pm(i,j  ))*u(i,j  ,k,nrhs)-              &
     &            (pm(i-1,j-1)+pm(i,j-1))*u(i,j-1,k,nrhs)))
#ifdef MASKING
            cff=cff*pmask(i,j)
#endif
            UFe(i,j)=om_p(i,j)*om_p(i,j)*cff
            VFx(i,j)=on_p(i,j)*on_p(i,j)*cff
          END DO
        END DO
!
!  Compute BASIC STATE first harmonic operator (m s^-3/2).
!
        DO j=JminU,JmaxU
          DO i=IminU,ImaxU
            LapU(i,j)=0.125_r8*                                         &
     &                (pm(i-1,j)+pm(i,j))*(pn(i-1,j)+pn(i,j))*          &
     &                ((pn(i-1,j)+pn(i,j))*(UFx(i,j  )-UFx(i-1,j))+     &
     &                 (pm(i-1,j)+pm(i,j))*(UFe(i,j+1)-UFe(i  ,j)))
          END DO
        END DO
        DO j=JminV,JmaxV
          DO i=IminV,ImaxV
            LapV(i,j)=0.125_r8*                                         &
     &                (pm(i,j)+pm(i,j-1))*(pn(i,j)+pn(i,j-1))*          &
     &                ((pn(i,j-1)+pn(i,j))*(VFx(i+1,j)-VFx(i,j  ))-     &
     &                 (pm(i,j-1)+pm(i,j))*(VFe(i  ,j)-VFe(i,j-1)))
          END DO
        END DO
!
!  Apply boundary conditions (other than periodic) to the BASIC STATE
!  first harmonic operator. These are gradient or closed (free slip or
!  no slip) boundary conditions.
!
        IF (.not.(CompositeGrid(iwest,ng).or.EWperiodic(ng))) THEN
          IF (DOMAIN(ng)%Western_Edge(tile)) THEN
            IF (ad_LBC(iwest,isUvel,ng)%closed) THEN
              DO j=JminU,JmaxU
                LapU(Istr,j)=0.0_r8
              END DO
            ELSE
              DO j=JminU,JmaxU
                LapU(Istr,j)=LapU(Istr+1,j)
              END DO
            END IF
            IF (ad_LBC(iwest,isVvel,ng)%closed) THEN
              DO j=JminV,JmaxV
                LapV(Istr-1,j)=gamma2(ng)*LapV(Istr,j)
              END DO
            ELSE
              DO j=JminV,JmaxV
                LapV(Istr-1,j)=0.0_r8
              END DO
            END IF
          END IF
        END IF
!
        IF (.not.(CompositeGrid(ieast,ng).or.EWperiodic(ng))) THEN
          IF (DOMAIN(ng)%Eastern_Edge(tile)) THEN
            IF (ad_LBC(ieast,isUvel,ng)%closed) THEN
              DO j=JminU,JmaxU
                LapU(Iend+1,j)=0.0_r8
              END DO
            ELSE
              DO j=JminU,JmaxU
                LapU(Iend+1,j)=LapU(Iend,j)
              END DO
            END IF
            IF (ad_LBC(ieast,isVvel,ng)%closed) THEN
              DO j=JminV,JmaxV
                LapV(Iend+1,j)=gamma2(ng)*LapV(Iend,j)
              END DO
            ELSE
              DO j=JminV,JmaxV
                LapV(Iend+1,j)=0.0_r8
              END DO
            END IF
          END IF
        END IF
!
        IF (.not.(CompositeGrid(isouth,ng).or.NSperiodic(ng))) THEN
          IF (DOMAIN(ng)%Southern_Edge(tile)) THEN
            IF (ad_LBC(isouth,isUvel,ng)%closed) THEN
              DO i=IminU,ImaxU
                LapU(i,Jstr-1)=gamma2(ng)*LapU(i,Jstr)
              END DO
            ELSE
              DO i=IminU,ImaxU
                LapU(i,Jstr-1)=0.0_r8
              END DO
            END IF
            IF (ad_LBC(isouth,isVvel,ng)%closed) THEN
              DO i=IminV,ImaxV
                LapV(i,Jstr)=0.0_r8
              END DO
            ELSE
              DO i=IminV,ImaxV
                LapV(i,Jstr)=LapV(i,Jstr+1)
              END DO
            END IF
          END IF
        END IF
!
        IF (.not.(CompositeGrid(inorth,ng).or.NSperiodic(ng))) THEN
          IF (DOMAIN(ng)%Northern_Edge(tile)) THEN
            IF (ad_LBC(inorth,isUvel,ng)%closed) THEN
              DO i=IminU,ImaxU
                LapU(i,Jend+1)=gamma2(ng)*LapU(i,Jend)
              END DO
            ELSE
              DO i=IminU,ImaxU
                LapU(i,Jend+1)=0.0_r8
              END DO
            END IF
            IF (ad_LBC(inorth,isVvel,ng)%closed) THEN
              DO i=IminV,ImaxV
                LapV(i,Jend+1)=0.0_r8
              END DO
            ELSE
              DO i=IminV,ImaxV
                LapV(i,Jend+1)=LapV(i,Jend)
              END DO
            END IF
          END IF
        END IF
!
        IF (.not.(CompositeGrid(isouth,ng).or.NSperiodic(ng).or.        &
     &            CompositeGrid(iwest ,ng).or.EWperiodic(ng))) THEN
          IF (DOMAIN(ng)%SouthWest_Corner(tile)) THEN
            LapU(Istr  ,Jstr-1)=0.5_r8*                                 &
     &                          (LapU(Istr+1,Jstr-1)+                   &
     &                           LapU(Istr  ,Jstr  ))
            LapV(Istr-1,Jstr  )=0.5_r8*                                 &
     &                          (LapV(Istr-1,Jstr+1)+                   &
     &                           LapV(Istr  ,Jstr  ))
          END IF
        END IF

        IF (.not.(CompositeGrid(isouth,ng).or.NSperiodic(ng).or.        &
     &            CompositeGrid(ieast ,ng).or.EWperiodic(ng))) THEN
          IF (DOMAIN(ng)%SouthEast_Corner(tile)) THEN
            LapU(Iend+1,Jstr-1)=0.5_r8*                                 &
     &                          (LapU(Iend  ,Jstr-1)+                   &
     &                           LapU(Iend+1,Jstr  ))
            LapV(Iend+1,Jstr  )=0.5_r8*                                 &
     &                          (LapV(Iend  ,Jstr  )+                   &
     &                           LapV(Iend+1,Jstr+1))
          END IF
        END IF

        IF (.not.(CompositeGrid(inorth,ng).or.NSperiodic(ng).or.        &
     &            CompositeGrid(iwest ,ng).or.EWperiodic(ng))) THEN
          IF (DOMAIN(ng)%NorthWest_Corner(tile)) THEN
            LapU(Istr  ,Jend+1)=0.5_r8*                                 &
     &                          (LapU(Istr+1,Jend+1)+                   &
     &                           LapU(Istr  ,Jend  ))
            LapV(Istr-1,Jend+1)=0.5_r8*                                 &
     &                          (LapV(Istr  ,Jend+1)+                   &
     &                           LapV(Istr-1,Jend  ))
          END IF
        END IF

        IF (.not.(CompositeGrid(inorth,ng).or.NSperiodic(ng).or.        &
     &            CompositeGrid(ieast ,ng).or.EWperiodic(ng))) THEN
          IF (DOMAIN(ng)%NorthEast_Corner(tile)) THEN
            LapU(Iend+1,Jend+1)=0.5_r8*                                 &
     &                          (LapU(Iend  ,Jend+1)+                   &
     &                           LapU(Iend+1,Jend  ))
            LapV(Iend+1,Jend+1)=0.5_r8*                                 &
     &                          (LapV(Iend  ,Jend+1)+                   &
     &                           LapV(Iend+1,Jend  ))
          END IF
        END IF
!
!  Time-step adjoint biharmonic, S-surfaces viscosity term.  Notice that
!  momentum at this stage is HzU and HzV and has units m2/s.
!
        DO j=JstrV,Jend
          DO i=Istr,Iend
            cff=0.25_r8*(pm(i,j)+pm(i,j-1))*(pn(i,j)+pn(i,j-1))
!!#ifdef DIAGNOSTICS_UV
!!          DiaRVfrc(i,j,3,M2hvis)=DiaRVfrc(i,j,3,M2hvis)-cff1
!!          DiaV3wrk(i,j,k,M3hvis)=-cff2
!!#endif
!>          tl_v(i,j,k,nnew)=tl_v(i,j,k,nnew)-tl_cff2
!>
            ad_cff2=ad_cff2-ad_v(i,j,k,nnew)
!>          tl_rvfrc(i,j)=tl_rvfrc(i,j)-tl_cff1
!>
            ad_cff1=ad_cff1-ad_rvfrc(i,j)
!>          tl_cff2=dt(ng)*cff*tl_cff1
!>
            ad_cff1=ad_cff1+dt(ng)*cff*ad_cff2
            ad_cff2=0.0_r8
!>          tl_cff1=0.5_r8*((pn(i,j-1)+pn(i,j))*                        &
!>   &                      (tl_VFx(i+1,j)-tl_VFx(i,j  ))-              &
!>   &                      (pm(i,j-1)+pm(i,j))*                        &
!>   &                      (tl_VFe(i  ,j)-tl_VFe(i,j-1)))
!>
            adfac=0.5_r8*ad_cff1
            adfac1=adfac*(pn(i,j-1)+pn(i,j))
            adfac2=adfac*(pm(i,j-1)+pm(i,j))
            ad_VFx(i  ,j  )=ad_VFx(i  ,j  )-adfac1
            ad_VFx(i+1,j  )=ad_VFx(i+1,j  )+adfac1
            ad_VFe(i  ,j-1)=ad_VFe(i  ,j-1)+adfac2
            ad_VFe(i  ,j  )=ad_VFe(i  ,j  )-adfac2
            ad_cff1=0.0_r8
          END DO
        END DO
        DO j=Jstr,Jend
          DO i=IstrU,Iend
            cff=0.25_r8*(pm(i-1,j)+pm(i,j))*(pn(i-1,j)+pn(i,j))
!!#ifdef DIAGNOSTICS_UV
!!          DiaRUfrc(i,j,3,M2hvis)=DiaRUfrc(i,j,3,M2hvis)-cff1
!!          DiaU3wrk(i,j,k,M3hvis)=-cff2
!!#endif
!>          tl_u(i,j,k,nnew)=tl_u(i,j,k,nnew)-tl_cff2
!>
            ad_cff2=ad_cff2-ad_u(i,j,k,nnew)
!>          tl_rufrc(i,j)=tl_rufrc(i,j)-tl_cff1
!>
            ad_cff1=ad_cff1-ad_rufrc(i,j)
!>          tl_cff2=dt(ng)*cff*tl_cff1
!>
            ad_cff1=ad_cff1+dt(ng)*cff*ad_cff2
            ad_cff2=0.0_r8
!>          tl_cff1=0.5_r8*((pn(i-1,j)+pn(i,j))*                        &
!>   &                      (tl_UFx(i,j  )-tl_UFx(i-1,j))+              &
!>   &                      (pm(i-1,j)+pm(i,j))*                        &
!>   &                      (tl_UFe(i,j+1)-tl_UFe(i  ,j)))
!>
            adfac=0.5_r8*ad_cff1
            adfac1=adfac*(pn(i-1,j)+pn(i,j))
            adfac2=adfac*(pm(i-1,j)+pm(i,j))
            ad_UFx(i-1,j  )=ad_UFx(i-1,j  )-adfac1
            ad_UFx(i  ,j  )=ad_UFx(i  ,j  )+adfac1
            ad_UFe(i  ,j  )=ad_UFe(i  ,j  )-adfac2
            ad_UFe(i  ,j+1)=ad_UFe(i  ,j+1)+adfac2
            ad_cff1=0.0_r8
          END DO
        END DO
!
!  Compute flux-components of the adjoint horizontal divergence of the
!  harmonic stress tensor (m4/s2) in XI- and ETA-directions.
!
        DO j=Jstr,Jend+1
          DO i=Istr,Iend+1
!>          tl_VFx(i,j)=on_p(i,j)*on_p(i,j)*tl_cff
!>
            ad_cff=ad_cff+on_p(i,j)*on_p(i,j)*ad_VFx(i,j)
            ad_VFx(i,j)=0.0_r8
!>          tl_UFe(i,j)=om_p(i,j)*om_p(i,j)*tl_cff
!>
            ad_cff=ad_cff+om_p(i,j)*om_p(i,j)*ad_UFe(i,j)
            ad_UFe(i,j)=0.0_r8
#ifdef MASKING
!>          tl_cff=tl_cff*pmask(i,j)
!>
            ad_cff=ad_cff*pmask(i,j)
#endif
!>          tl_cff=visc4_p(i,j)*0.125_r8*                               &
!>   &             ((tl_Hz(i-1,j  ,k)+tl_Hz(i,j  ,k)+                   &
!>   &               tl_Hz(i-1,j-1,k)+tl_Hz(i,j-1,k))*                  &
!>   &              (pmon_p(i,j)*                                       &
!>   &               ((pn(i  ,j-1)+pn(i  ,j))*LapV(i  ,j)-              &
!>   &                (pn(i-1,j-1)+pn(i-1,j))*LapV(i-1,j))+             &
!>   &               pnom_p(i,j)*                                       &
!>   &               ((pm(i-1,j  )+pm(i,j  ))*LapU(i,j  )-              &
!>   &                (pm(i-1,j-1)+pm(i,j-1))*LapU(i,j-1)))+            &
!>   &              (Hz(i-1,j  ,k)+Hz(i,j  ,k)+                         &
!>   &               Hz(i-1,j-1,k)+Hz(i,j-1,k))*                        &
!>   &               (pmon_p(i,j)*                                      &
!>   &                ((pn(i  ,j-1)+pn(i  ,j))*tl_LapV(i  ,j)-          &
!>   &                 (pn(i-1,j-1)+pn(i-1,j))*tl_LapV(i-1,j))+         &
!>   &                pnom_p(i,j)*                                      &
!>   &                ((pm(i-1,j  )+pm(i,j  ))*tl_LapU(i,j  )-          &
!>   &                 (pm(i-1,j-1)+pm(i,j-1))*tl_LapU(i,j-1))))
!>
            adfac=visc4_p(i,j)*0.125_r8*ad_cff
            adfac1=adfac*(pmon_p(i,j)*                                  &
     &                    ((pn(i  ,j-1)+pn(i  ,j))*LapV(i  ,j)-         &
     &                     (pn(i-1,j-1)+pn(i-1,j))*LapV(i-1,j))+        &
     &                    pnom_p(i,j)*                                  &
     &                    ((pm(i-1,j  )+pm(i,j  ))*LapU(i,j  )-         &
     &                     (pm(i-1,j-1)+pm(i,j-1))*LapU(i,j-1)))
            adfac2=adfac*(Hz(i-1,j  ,k)+Hz(i,j  ,k)+                    &
     &                    Hz(i-1,j-1,k)+Hz(i,j-1,k))
            adfac3=adfac2*pmon_p(i,j)
            adfac4=adfac2*pnom_p(i,j)
            ad_Hz(i-1,j-1,k)=ad_Hz(i-1,j-1,k)+adfac1
            ad_Hz(i-1,j  ,k)=ad_Hz(i-1,j  ,k)+adfac1
            ad_Hz(i  ,j-1,k)=ad_Hz(i  ,j-1,k)+adfac1
            ad_Hz(i  ,j  ,k)=ad_Hz(i  ,j  ,k)+adfac1
            ad_LapV(i-1,j)=ad_LapV(i-1,j)-                              &
     &                     (pn(i-1,j-1)+pn(i-1,j))*adfac3
            ad_LapV(i  ,j)=ad_LapV(i  ,j)+                              &
     &                     (pn(i  ,j-1)+pn(i  ,j))*adfac3
            ad_LapU(i,j-1)=ad_LapU(i,j-1)-                              &
     &                     (pm(i-1,j-1)+pm(i,j-1))*adfac4
            ad_LapU(i,j  )=ad_LapU(i,j  )+                              &
     &                     (pm(i-1,j  )+pm(i,j  ))*adfac4
            ad_cff=0.0_r8
          END DO
        END DO
!
        DO j=JstrV-1,Jend
          DO i=IstrU-1,Iend
!>          tl_VFe(i,j)=om_r(i,j)*om_r(i,j)*tl_cff
!>
            ad_cff=ad_cff+om_r(i,j)*om_r(i,j)*ad_VFe(i,j)
            ad_VFe(i,j)=0.0_r8
!>          tl_UFx(i,j)=on_r(i,j)*on_r(i,j)*tl_cff
!>
            ad_cff=ad_cff+on_r(i,j)*on_r(i,j)*ad_UFx(i,j)
            ad_UFx(i,j)=0.0_r8
!>          tl_cff=visc4_r(i,j)*0.5_r8*                                 &
!>   &             (tl_Hz(i,j,k)*
!>   &              (pmon_r(i,j)*                                       &
!>   &               ((pn(i  ,j)+pn(i+1,j))*LapU(i+1,j)-                &
!>   &                (pn(i-1,j)+pn(i  ,j))*LapU(i  ,j))-               &
!>   &               pnom_r(i,j)*                                       &
!>   &               ((pm(i,j  )+pm(i,j+1))*LapV(i,j+1)-                &
!>   &                (pm(i,j-1)+pm(i,j  ))*LapV(i,j  )))+              &
!>   &              Hz(i,j,k)*                                          &
!>   &              (pmon_r(i,j)*                                       &
!>   &               ((pn(i  ,j)+pn(i+1,j))*tl_LapU(i+1,j)-             &
!>   &                (pn(i-1,j)+pn(i  ,j))*tl_LapU(i  ,j))-            &
!>   &               pnom_r(i,j)*                                       &
!>   &               ((pm(i,j  )+pm(i,j+1))*tl_LapV(i,j+1)-             &
!>   &                (pm(i,j-1)+pm(i,j  ))*tl_LapV(i,j  ))))
!>
            adfac=visc4_r(i,j)*0.5_r8*ad_cff
            adfac1=adfac*Hz(i,j,k)
            adfac2=adfac1*pmon_r(i,j)
            adfac3=adfac1*pnom_r(i,j)
            ad_Hz(i,j,k)=ad_Hz(i,j,k)+                                  &
     &                   (pmon_r(i,j)*                                  &
     &                    ((pn(i  ,j)+pn(i+1,j))*LapU(i+1,j)-           &
     &                     (pn(i-1,j)+pn(i  ,j))*LapU(i  ,j))-          &
     &                    pnom_r(i,j)*                                  &
     &                    ((pm(i,j  )+pm(i,j+1))*LapV(i,j+1)-           &
     &                     (pm(i,j-1)+pm(i,j  ))*LapV(i,j  )))*adfac
            ad_LapU(i  ,j)=ad_LapU(i  ,j)-                              &
     &                     (pn(i-1,j)+pn(i  ,j))*adfac2
            ad_LapU(i+1,j)=ad_LapU(i+1,j)+                              &
     &                     (pn(i  ,j)+pn(i+1,j))*adfac2
            ad_LapV(i,j  )=ad_LapV(i,j  )+                              &
     &                     (pm(i,j-1)+pm(i,j  ))*adfac3
            ad_LapV(i,j+1)=ad_LapV(i,j+1)-                              &
     &                     (pm(i,j  )+pm(i,j+1))*adfac3
            ad_cff=0.0_r8
          END DO
        END DO
!
!  Apply boundary conditions (other than periodic) to the first
!  adjoint harmonic operator. These are gradient or closed
!  (free slip or no slip) boundary conditions.
!
        IF (.not.(CompositeGrid(inorth,ng).or.NSperiodic(ng).or.        &
     &            CompositeGrid(ieast ,ng).or.EWperiodic(ng))) THEN
          IF (DOMAIN(ng)%NorthEast_Corner(tile)) THEN
!>          tl_LapV(Iend+1,Jend+1)=0.5_r8*                              &
!>   &                             (tl_LapV(Iend  ,Jend+1)+             &
!>   &                              tl_LapV(Iend+1,Jend  ))
!>
            adfac=0.5_r8*ad_LapV(Iend+1,Jend+1)
            ad_LapV(Iend  ,Jend+1)=ad_LapV(Iend  ,Jend+1)+adfac
            ad_LapV(Iend+1,Jend  )=ad_LapV(Iend+1,Jend  )+adfac
            ad_LapV(Iend+1,Jend+1)=0.0_r8
!>          tl_LapU(Iend+1,Jend+1)=0.5_r8*                              &
!>   &                             (tl_LapU(Iend  ,Jend+1)+             &
!>   &                              tl_LapU(Iend+1,Jend  ))
!>
            adfac=0.5_r8*ad_LapU(Iend+1,Jend+1)
            ad_LapU(Iend  ,Jend+1)=ad_LapU(Iend  ,Jend+1)+adfac
            ad_LapU(Iend+1,Jend  )=ad_LapU(Iend+1,Jend  )+adfac
            ad_LapU(Iend+1,Jend+1)=0.0_r8
          END IF
        END IF

        IF (.not.(CompositeGrid(inorth,ng).or.NSperiodic(ng).or.        &
     &            CompositeGrid(iwest ,ng).or.EWperiodic(ng))) THEN
          IF (DOMAIN(ng)%NorthWest_Corner(tile)) THEN
!>          tl_LapV(Istr-1,Jend+1)=0.5_r8*                              &
!>   &                             (tl_LapV(Istr  ,Jend+1)+             &
!>   &                              tl_LapV(Istr-1,Jend  ))
!>
            adfac=0.5_r8*ad_LapV(Istr-1,Jend+1)
            ad_LapV(Istr  ,Jend+1)=ad_LapV(Istr  ,Jend+1)+adfac
            ad_LapV(Istr-1,Jend  )=ad_LapV(Istr-1,Jend  )+adfac
            ad_LapV(Istr-1,Jend+1)=0.0_r8
!>          tl_LapU(Istr  ,Jend+1)=0.5_r8*                              &
!>   &                             (tl_LapU(Istr+1,Jend+1)+             &
!>   &                              tl_LapU(Istr  ,Jend  ))
!>
            adfac=0.5_r8*ad_LapU(Istr,Jend+1)
            ad_LapU(Istr+1,Jend+1)=ad_LapU(Istr+1,Jend+1)+adfac
            ad_LapU(Istr  ,Jend  )=ad_LapU(Istr  ,Jend  )+adfac
            ad_LapU(Istr  ,Jend+1)=0.0_r8
          END IF
        END IF

        IF (.not.(CompositeGrid(isouth,ng).or.NSperiodic(ng).or.        &
     &            CompositeGrid(ieast ,ng).or.EWperiodic(ng))) THEN
          IF (DOMAIN(ng)%SouthEast_Corner(tile)) THEN
!>          tl_LapV(Iend+1,Jstr  )=0.5_r8*                              &
!>   &                             (tl_LapV(Iend  ,Jstr  )+             &
!>   &                              tl_LapV(Iend+1,Jstr+1))
!>
            adfac=0.5_r8*ad_LapV(Iend+1,Jstr)
            ad_LapV(Iend  ,Jstr  )=ad_LapV(Iend  ,Jstr  )+adfac
            ad_LapV(Iend+1,Jstr+1)=ad_LapV(Iend+1,Jstr+1)+adfac
            ad_LapV(Iend+1,Jstr  )=0.0_r8
!>          tl_LapU(Iend+1,Jstr-1)=0.5_r8*                              &
!>   &                             (tl_LapU(Iend  ,Jstr-1)+             &
!>   &                              tl_LapU(Iend+1,Jstr  ))
!>
            adfac=0.5_r8*ad_LapU(Iend+1,Jstr-1)
            ad_LapU(Iend  ,Jstr-1)=ad_LapU(Iend  ,Jstr-1)+adfac
            ad_LapU(Iend+1,Jstr  )=ad_LapU(Iend+1,Jstr  )+adfac
            ad_LapU(Iend+1,Jstr-1)=0.0_r8
          END IF
        END IF

        IF (.not.(CompositeGrid(isouth,ng).or.NSperiodic(ng).or.        &
     &            CompositeGrid(iwest ,ng).or.EWperiodic(ng))) THEN
          IF (DOMAIN(ng)%SouthWest_Corner(tile)) THEN
!>          tl_LapV(Istr-1,Jstr  )=0.5_r8*                              &
!>   &                             (tl_LapV(Istr-1,Jstr+1)+             &
!>   &                              tl_LapV(Istr  ,Jstr  ))
!>
            adfac=0.5_r8*ad_LapV(Istr-1,Jstr)
            ad_LapV(Istr-1,Jstr+1)=ad_LapV(Istr-1,Jstr+1)+adfac
            ad_LapV(Istr  ,Jstr  )=ad_LapV(Istr  ,Jstr  )+adfac
            ad_LapV(Istr-1,Jstr  )=0.0_r8
!>          tl_LapU(Istr  ,Jstr-1)=0.5_r8*                              &
!>   &                             (tl_LapU(Istr+1,Jstr-1)+             &
!>   &                              tl_LapU(Istr  ,Jstr  ))
!>
            adfac=0.5_r8*ad_LapU(Istr,Jstr-1)
            ad_LapU(Istr+1,Jstr-1)=ad_LapU(Istr+1,Jstr-1)+adfac
            ad_LapU(Istr  ,Jstr  )=ad_LapU(Istr  ,Jstr  )+adfac
            ad_LapU(Istr  ,Jstr-1)=0.0_r8
          END IF
        END IF
!
        IF (.not.(CompositeGrid(inorth,ng).or.NSperiodic(ng))) THEN
          IF (DOMAIN(ng)%Northern_Edge(tile)) THEN
            IF (ad_LBC(inorth,isVvel,ng)%closed) THEN
              DO i=IminV,ImaxV
!>              tl_LapV(i,Jend+1)=0.0_r8
!>
                ad_LapV(i,Jend+1)=0.0_r8
              END DO
            ELSE
              DO i=IminV,ImaxV
!>              tl_LapV(i,Jend+1)=tl_LapV(i,Jend)
!>
                ad_LapV(i,Jend)=ad_LapV(i,Jend)+ad_LapV(i,Jend+1)
                ad_LapV(i,Jend+1)=0.0_r8
              END DO
            END IF
            IF (ad_LBC(inorth,isUvel,ng)%closed) THEN
              DO i=IminU,ImaxU
!>              tl_LapU(i,Jend+1)=gamma2(ng)*tl_LapU(i,Jend)
!>
                ad_LapU(i,Jend)=ad_LapU(i,Jend)+                        &
     &                          gamma2(ng)*ad_LapU(i,Jend+1)
                ad_LapU(i,Jend+1)=0.0_r8
              END DO
            ELSE
              DO i=IminU,ImaxU
!>              tl_LapU(i,Jend+1)=0.0_r8
!>
                ad_LapU(i,Jend+1)=0.0_r8
              END DO
            END IF
          END IF
        END IF
!
        IF (.not.(CompositeGrid(isouth,ng).or.NSperiodic(ng))) THEN
          IF (DOMAIN(ng)%Southern_Edge(tile)) THEN
            IF (ad_LBC(isouth,isVvel,ng)%closed) THEN
              DO i=IminV,ImaxV
!>              tl_LapV(i,JstrV-1)=0.0_r8
!>
                ad_LapV(i,JstrV-1)=0.0_r8
              END DO
            ELSE
              DO i=IminV,ImaxV
!>              tl_LapV(i,JstrV-1)=tl_LapV(i,JstrV)
!>
                ad_LapV(i,JstrV)=ad_LapV(i,JstrV)+ad_LapV(i,JstrV-1)
                ad_LapV(i,JstrV-1)=0.0_r8
              END DO
            END IF
            IF (ad_LBC(isouth,isUvel,ng)%closed) THEN
              DO i=IminU,ImaxU
!>              tl_LapU(i,Jstr-1)=gamma2(ng)*tl_LapU(i,Jstr)
!>
                ad_LapU(i,Jstr)=ad_LapU(i,Jstr)+                        &
     &                          gamma2(ng)*ad_LapU(i,Jstr-1)
                ad_LapU(i,Jstr-1)=0.0_r8
              END DO
            ELSE
              DO i=IminU,ImaxU
!>              tl_LapU(i,Jstr-1)=0.0_r8
!>
                ad_LapU(i,Jstr-1)=0.0_r8
              END DO
            END IF
          END IF
        END IF
!
        IF (.not.(CompositeGrid(ieast,ng).or.EWperiodic(ng))) THEN
          IF (DOMAIN(ng)%Eastern_Edge(tile)) THEN
            IF (ad_LBC(ieast,isVvel,ng)%closed) THEN
              DO j=JminV,JmaxV
!>              tl_LapV(Iend+1,j)=gamma2(ng)*tl_LapV(Iend,j)
!>
                ad_LapV(Iend,j)=ad_LapV(Iend,j)+                        &
     &                          gamma2(ng)*ad_LapV(Iend+1,j)
                ad_LapV(Iend+1,j)=0.0_r8
              END DO
            ELSE
              DO j=JminV,JmaxV
!>              tl_LapV(Iend+1,j)=0.0_r8
!>
                ad_LapV(Iend+1,j)=0.0_r8
              END DO
            END IF
            IF (ad_LBC(ieast,isUvel,ng)%closed) THEN
              DO j=JminU,JmaxU
!>              tl_LapU(Iend+1,j)=0.0_r8
!>
                ad_LapU(Iend+1,j)=0.0_r8
              END DO
            ELSE
              DO j=JminU,JmaxU
!>              tl_LapU(Iend+1,j)=tl_LapU(Iend,j)
!>
                ad_LapU(Iend,j)=ad_LapU(Iend,j)+ad_LapU(Iend+1,j)
                ad_LapU(Iend+1,j)=0.0_r8
              END DO
            END IF
          END IF
        END IF
!
        IF (.not.(CompositeGrid(iwest,ng).or.EWperiodic(ng))) THEN
          IF (DOMAIN(ng)%Western_Edge(tile)) THEN
            IF (ad_LBC(iwest,isVvel,ng)%closed) THEN
              DO j=JminV,JmaxV
!>              tl_LapV(Istr-1,j)=gamma2(ng)*tl_LapV(Istr,j)
!>
                ad_LapV(Istr,j)=ad_LapV(Istr,j)+                        &
     &                          gamma2(ng)*ad_LapV(Istr-1,j)
                ad_LapV(Istr-1,j)=0.0_r8
              END DO
            ELSE
              DO j=JminV,JmaxV
!>              tl_LapV(Istr-1,j)=0.0_r8
!>
                ad_LapV(Istr-1,j)=0.0_r8
              END DO
            END IF
            IF (ad_LBC(iwest,isUvel,ng)%closed) THEN
              DO j=JminU,JmaxU
!>              tl_LapU(IstrU-1,j)=0.0_r8
!>
                ad_LapU(IstrU-1,j)=0.0_r8
              END DO
            ELSE
              DO j=JminU,JmaxU
!>              tl_LapU(IstrU-1,j)=tl_LapU(IstrU,j)
!>
                ad_LapU(IstrU,j)=ad_LapU(IstrU,j)+ad_LapU(IstrU-1,j)
                ad_LapU(IstrU-1,j)=0.0_r8
              END DO
            END IF
          END IF
        END IF
!
!  Compute adjoint first harmonic operator (m s^-3/2).
!
        DO j=JminV,JmaxV
          DO i=IminV,ImaxV
            cff=0.125_r8*(pm(i,j)+pm(i,j-1))*(pn(i,j)+pn(i,j-1))
!>          tl_LapV(i,j)=cff*                                           &
!>   &                   ((pn(i,j-1)+pn(i,j))*                          &
!>   &                    (tl_VFx(i+1,j)-tl_VFx(i,j  ))-                &
!>   &                    (pm(i,j-1)+pm(i,j))*                          &
!>   &                    (tl_VFe(i  ,j)-tl_VFe(i,j-1)))
!>
            adfac=cff*ad_LapV(i,j)
            adfac1=adfac*(pn(i,j-1)+pn(i,j))
            adfac2=adfac*(pm(i,j-1)+pm(i,j))
            ad_VFx(i  ,j)=ad_VFx(i  ,j)-adfac1
            ad_VFx(i+1,j)=ad_VFx(i+1,j)+adfac1
            ad_VFe(i,j-1)=ad_VFe(i,j-1)+adfac2
            ad_VFe(i,  j)=ad_VFe(i,  j)-adfac2
            ad_LapV(i,j)=0.0_r8
          END DO
        END DO
        DO j=JminU,JmaxU
          DO i=IminU,ImaxU
            cff=0.125_r8*(pm(i-1,j)+pm(i,j))*(pn(i-1,j)+pn(i,j))
!>          tl_LapU(i,j)=cff*                                           &
!>   &                   ((pn(i-1,j)+pn(i,j))*                          &
!>   &                    (tl_UFx(i,j  )-tl_UFx(i-1,j))+                &
!>   &                    (pm(i-1,j)+pm(i,j))*                          &
!>   &                    (tl_UFe(i,j+1)-tl_UFe(i  ,j)))
!>
            adfac=cff*ad_LapU(i,j)
            adfac1=adfac*(pn(i-1,j)+pn(i,j))
            adfac2=adfac*(pm(i-1,j)+pm(i,j))
            ad_UFx(i-1,j)=ad_UFx(i-1,j)-adfac1
            ad_UFx(i ,j )=ad_UFx(i  ,j)+adfac1
            ad_UFe(i,j  )=ad_UFe(i,j  )-adfac2
            ad_UFe(i,j+1)=ad_UFe(i,j+1)+adfac2
            ad_LapU(i,j)=0.0_r8
          END DO
        END DO
!
!  Compute flux-components of the horizontal divergence of the stress
!  tensor (m4 s^-3/2) in XI- and ETA-directions.  It is assumed here
!  that "visc4_r" and "visc4_p" are the squared root of the biharmonic
!  viscosity coefficient.  For momentum balance purposes, the
!  thickness "Hz" appears only when computing the second harmonic
!  operator.
!
        DO j=JminU,JmaxU+1
          DO i=IminV,ImaxV+1
!>          tl_VFx(i,j)=on_p(i,j)*on_p(i,j)*tl_cff
!>
            ad_cff=ad_cff+on_p(i,j)*on_p(i,j)*ad_VFx(i,j)
            ad_VFx(i,j)=0.0_r8
!>          tl_UFe(i,j)=om_p(i,j)*om_p(i,j)*tl_cff
!>
            ad_cff=ad_cff+om_p(i,j)*om_p(i,j)*ad_UFe(i,j)
            ad_UFe(i,j)=0.0_r8
#ifdef MASKING
!>          tl_cff=tl_cff*pmask(i,j)
!>
            ad_cff=ad_cff*pmask(i,j)
#endif
!>          tl_cff=visc4_p(i,j)*0.5_r8*                                 &
!>   &          (pmon_p(i,j)*                                           &
!>   &           ((pn(i  ,j-1)+pn(i  ,j))*tl_v(i  ,j,k,nrhs)-           &
!>   &            (pn(i-1,j-1)+pn(i-1,j))*tl_v(i-1,j,k,nrhs))+          &
!>   &           pnom_p(i,j)*                                           &
!>   &           ((pm(i-1,j  )+pm(i,j  ))*tl_u(i,j  ,k,nrhs)-           &
!>   &            (pm(i-1,j-1)+pm(i,j-1))*tl_u(i,j-1,k,nrhs)))
!>
            adfac=visc4_p(i,j)*0.5_r8*ad_cff
            adfac1=adfac*pmon_p(i,j)
            adfac2=adfac*pnom_p(i,j)
            ad_v(i-1,j,k,nrhs)=ad_v(i-1,j,k,nrhs)-                      &
     &                         (pn(i-1,j-1)+pn(i-1,j))*adfac1
            ad_v(i  ,j,k,nrhs)=ad_v(i  ,j,k,nrhs)+                      &
     &                         (pn(i  ,j-1)+pn(i  ,j))*adfac1
            ad_u(i,j  ,k,nrhs)=ad_u(i,j  ,k,nrhs)+                      &
     &                         (pm(i-1,j  )+pm(i,j  ))*adfac2
            ad_u(i,j-1,k,nrhs)=ad_u(i,j-1,k,nrhs)-                      &
     &                         (pm(i-1,j-1)+pm(i,j-1))*adfac2
            ad_cff=0.0_r8
          END DO
        END DO
        DO j=-1+JminV,JmaxV
          DO i=-1+IminU,ImaxU
!>          tl_VFe(i,j)=om_r(i,j)*om_r(i,j)*tl_cff
!>
            ad_cff=ad_cff+om_r(i,j)*om_r(i,j)*ad_VFe(i,j)
            ad_VFe(i,j)=0.0_r8
!>          tl_UFx(i,j)=on_r(i,j)*on_r(i,j)*tl_cff
!>
            ad_cff=ad_cff+on_r(i,j)*on_r(i,j)*ad_UFx(i,j)
            ad_UFx(i,j)=0.0_r8
!>          tl_cff=visc4_r(i,j)*0.5_r8*                                 &
!>   &          (pmon_r(i,j)*                                           &
!>   &           ((pn(i  ,j)+pn(i+1,j))*tl_u(i+1,j,k,nrhs)-             &
!>   &            (pn(i-1,j)+pn(i  ,j))*tl_u(i  ,j,k,nrhs))-            &
!>   &           pnom_r(i,j)*                                           &
!>   &           ((pm(i,j  )+pm(i,j+1))*tl_v(i,j+1,k,nrhs)-             &
!>   &            (pm(i,j-1)+pm(i,j  ))*tl_v(i,j  ,k,nrhs)))
!>
            adfac=visc4_r(i,j)*0.5_r8*ad_cff
            adfac1=adfac*pmon_r(i,j)
            adfac2=adfac*pnom_r(i,j)
            ad_u(i  ,j,k,nrhs)=ad_u(i  ,j,k,nrhs)-                      &
     &                         (pn(i-1,j)+pn(i  ,j))*adfac1
            ad_u(i+1,j,k,nrhs)=ad_u(i+1,j,k,nrhs)+                      &
     &                         (pn(i  ,j)+pn(i+1,j))*adfac1
            ad_v(i,j  ,k,nrhs)=ad_v(i,j  ,k,nrhs)+                      &
     &                         (pm(i,j-1)+pm(i,j  ))*adfac2
            ad_v(i,j+1,k,nrhs)=ad_v(i,j+1,k,nrhs)-                      &
     &                         (pm(i,j  )+pm(i,j+1))*adfac2
            ad_cff=0.0_r8
          END DO
        END DO
      END DO K_LOOP
!
      RETURN
      END SUBROUTINE ad_uv3dmix4_tile
