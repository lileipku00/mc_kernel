!******************************************************************************
!
!    This file is part of:
!    MC Kernel: Calculating seismic sensitivity kernels on unstructured meshes
!    Copyright (C) 2016 Simon Staehler, Martin van Driel, Ludwig Auer
!
!    You can find the latest version of the software at:
!    <https://www.github.com/tomography/mckernel>
!
!    MC Kernel is free software: you can redistribute it and/or modify
!    it under the terms of the GNU General Public License as published by
!    the Free Software Foundation, either version 3 of the License, or
!    (at your option) any later version.
!
!    MC Kernel is distributed in the hope that it will be useful,
!    but WITHOUT ANY WARRANTY; without even the implied warranty of
!    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!    GNU General Public License for more details.
!
!    You should have received a copy of the GNU General Public License
!    along with MC Kernel. If not, see <http://www.gnu.org/licenses/>.
!
!******************************************************************************

!=========================================================================================
module test_background_model

  use global_parameters
  use background_model
  use ftnunit

  implicit none
  public
contains
!-----------------------------------------------------------------------------------------
subroutine test_background_model_combine
  type(backgroundmodel_type) :: bm
  real(kind=sp), allocatable :: coeffs(:,:)
  real(kind=sp)              :: ref_vs (1)
  real(kind=sp)              :: ref_vp (1)
  real(kind=sp)              :: ref_rho(1)
  real(kind=sp)              :: ref_vsh(1)
  real(kind=sp)              :: ref_vsv(1)
  real(kind=sp)              :: ref_vph(1)
  real(kind=sp)              :: ref_vpv(1)
  real(kind=sp)              :: ref_eta(1)
  real(kind=sp)              :: ref_phi(1)
  real(kind=sp)              :: ref_xi(1)
  real(kind=sp)              :: ref_lam(1)
  real(kind=sp)              :: ref_mu(1)

  allocate(coeffs(6,1))
  coeffs(:,1) = [4500.0, 3000.0, 2000.0, 1.1, 0.9, 1.0]

  ref_vs  = 3000.0
  ref_vp  = 4500.0
  ref_rho = 2000.0
  ref_eta = 1
  ref_phi = 1.1
  ref_xi  = 0.9
  ref_vsh = ref_vs
  ref_vsv = sqrt(ref_vsh**2/ref_xi)
  ref_vph = ref_vp
  ref_vpv = sqrt(ref_vph**2*ref_phi)
  ref_lam = ref_rho * (ref_vp**2 - 2 * ref_vs**2)
  ref_mu  = ref_rho * ref_vs**2

  call bm%combine(coeffs)

  call assert_comparable(bm%c_vs,  ref_vs,  1e-7, 'VS correct')
  call assert_comparable(bm%c_vp,  ref_vp,  1e-7, 'VP correct')
  call assert_comparable(bm%c_rho, ref_rho, 1e-7, 'Rho correct')
  call assert_comparable(bm%c_vsh, ref_vsh, 1e-7, 'VSh correct')
  call assert_comparable(bm%c_vsv, ref_vsv, 1e-7, 'VSv correct')
  call assert_comparable(bm%c_vph, ref_vph, 1e-7, 'VPh correct')
  call assert_comparable(bm%c_vpv, ref_vpv, 1e-7, 'VPv correct')
  call assert_comparable(bm%c_eta, ref_eta, 1e-7, 'Eta correct')
  call assert_comparable(bm%c_phi, ref_phi, 1e-7, 'Phi correct')
  call assert_comparable(bm%c_xi,  ref_xi,  1e-7, 'Xi correct')
  call assert_comparable(bm%c_lam, ref_lam, 1e-7, 'Lambda correct')
  call assert_comparable(bm%c_mu,  ref_mu,  1e-7, 'Mu correct')

  deallocate(coeffs)
  allocate(coeffs(6,1))
  coeffs(:,1) = [6000.0, 0000.0, 4000.0, 1.0, 0.9, 1.0]

  ref_vs  = 0000.0
  ref_vp  = 6000.0
  ref_rho = 4000.0
  ref_eta = 1
  ref_phi = 1.0
  ref_xi  = 0.9
  ref_vsh = ref_vs
  ref_vsv = sqrt(ref_vsh**2/ref_xi)
  ref_vph = ref_vp
  ref_vpv = sqrt(ref_vph**2*ref_phi)
  ref_lam = ref_rho * (ref_vp**2 - 2 * ref_vs**2)
  ref_mu  = ref_rho * ref_vs**2

  call bm%combine(coeffs)

  call assert_comparable(bm%c_vs,  ref_vs,  1e-7, 'VS correct')
  call assert_comparable(bm%c_vp,  ref_vp,  1e-7, 'VP correct')
  call assert_comparable(bm%c_rho, ref_rho, 1e-7, 'Rho correct')
  call assert_comparable(bm%c_vsh, ref_vsh, 1e-7, 'VSh correct')
  call assert_comparable(bm%c_vsv, ref_vsv, 1e-7, 'VSv correct')
  call assert_comparable(bm%c_vph, ref_vph, 1e-7, 'VPh correct')
  call assert_comparable(bm%c_vpv, ref_vpv, 1e-7, 'VPv correct')
  call assert_comparable(bm%c_eta, ref_eta, 1e-7, 'Eta correct')
  call assert_comparable(bm%c_phi, ref_phi, 1e-7, 'Phi correct')
  call assert_comparable(bm%c_xi,  ref_xi,  1e-7, 'Xi correct')
  call assert_comparable(bm%c_lam, ref_lam, 1e-7, 'Lambda correct')
  call assert_comparable(bm%c_mu,  ref_mu,  1e-7, 'Mu correct')

  deallocate(coeffs)
  allocate(coeffs(6,2))
  coeffs(:,1) = [11000.0, 7000.0, 12000.0, 1.2, 0.7, 2.0]
  coeffs(:,2) = [11000.0, 7000.0, 12000.0, 1.2, 0.7, 2.0]

  ref_vs  = 7000.0
  ref_vp  = 11000.0
  ref_rho = 12000.0
  ref_eta = 2
  ref_phi = 1.2
  ref_xi  = 0.7
  ref_vsh = ref_vs
  ref_vsv = sqrt(ref_vsh**2/ref_xi)
  ref_vph = ref_vp
  ref_vpv = sqrt(ref_vph**2*ref_phi)
  ref_lam = ref_rho * (ref_vp**2 - 2 * ref_vs**2)
  ref_mu  = ref_rho * ref_vs**2

  call bm%combine(coeffs)

  call assert_comparable(bm%c_vs(1),  ref_vs(1),  1e-7, 'VS correct')
  call assert_comparable(bm%c_vp(1),  ref_vp(1),  1e-7, 'VP correct')
  call assert_comparable(bm%c_rho(1), ref_rho(1), 1e-7, 'Rho correct')
  call assert_comparable(bm%c_vsh(1), ref_vsh(1), 1e-7, 'VSh correct')
  call assert_comparable(bm%c_vsv(1), ref_vsv(1), 1e-7, 'VSv correct')
  call assert_comparable(bm%c_vph(1), ref_vph(1), 1e-7, 'VPh correct')
  call assert_comparable(bm%c_vpv(1), ref_vpv(1), 1e-7, 'VPv correct')
  call assert_comparable(bm%c_eta(1), ref_eta(1), 1e-7, 'Eta correct')
  call assert_comparable(bm%c_phi(1), ref_phi(1), 1e-7, 'Phi correct')
  call assert_comparable(bm%c_xi(1),  ref_xi(1),  1e-7, 'Xi correct')
  call assert_comparable(bm%c_lam(1), ref_lam(1), 1e-7, 'Lambda correct')
  call assert_comparable(bm%c_mu(1),  ref_mu(1),  1e-7, 'Mu correct')
  
end subroutine test_background_model_combine
!-----------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------
subroutine test_background_model_weight
  type(backgroundmodel_type) :: bm
  real(kind=sp), allocatable :: coeffs(:,:)
  real(kind=dp), allocatable :: params(:,:)
  real(kind=dp)              :: ref_vs (1)
  real(kind=dp)              :: ref_vp (1)
  real(kind=dp)              :: ref_rho(1)
  real(kind=dp)              :: ref_vsh(1)
  real(kind=dp)              :: ref_vsv(1)
  real(kind=dp)              :: ref_vph(1)
  real(kind=dp)              :: ref_vpv(1)
  real(kind=dp)              :: ref_eta(1)
  real(kind=dp)              :: ref_phi(1)
  real(kind=dp)              :: ref_xi(1)

  allocate(coeffs(6,2))
  coeffs(:,1) = [4500.0, 3000.0, 2000.0, 1.1, 0.9, 1.0]
  coeffs(:,2) = [4500.0, 3000.0, 2000.0, 1.1, 0.9, 1.0]

  ref_vs  = 3000.0
  ref_vp  = 4500.0
  ref_rho = 2000.0
  ref_eta = 1
  ref_phi = 1.1
  ref_xi  = 0.9
  ref_vsh = ref_vs
  ref_vsv = sqrt(ref_vsh**2/ref_xi)
  ref_vph = ref_vp
  ref_vpv = sqrt(ref_vph**2*ref_phi)
  call bm%combine(coeffs)

  allocate(params(10, 2))
  params = bm%weight([1.d0, 3.d0])

  ! First weight was 1
  call assert_comparable(params( 1,1), ref_vp(1),  1d-7, 'VP correct')
  call assert_comparable(params( 2,1), ref_vs(1),  1d-7, 'VS correct')
  call assert_comparable(params( 3,1), ref_rho(1), 1d-7, 'Rho correct')
  call assert_comparable(params( 4,1), ref_vph(1), 1d-7, 'VPh correct')
  call assert_comparable(params( 5,1), ref_vpv(1), 1d-7, 'VPv correct')
  call assert_comparable(params( 6,1), ref_vsh(1), 1d-7, 'VSh correct')
  call assert_comparable(params( 7,1), ref_vsv(1), 1d-7, 'VSv correct')
  call assert_comparable(params( 8,1), ref_eta(1), 1d-7, 'Eta correct')
  call assert_comparable(params( 9,1), ref_phi(1), 1d-7, 'Phi correct')
  call assert_comparable(params(10,1), ref_xi(1),  1d-7, 'Xi correct')

  ! Second weight is 3
  call assert_comparable(params( 1,2), 3.d0*ref_vp(1),  1d-7, 'VP correct')
  call assert_comparable(params( 2,2), 3.d0*ref_vs(1),  1d-7, 'VS correct')
  call assert_comparable(params( 3,2), 3.d0*ref_rho(1), 1d-7, 'Rho correct')
  call assert_comparable(params( 4,2), 3.d0*ref_vph(1), 1d-7, 'VPh correct')
  call assert_comparable(params( 5,2), 3.d0*ref_vpv(1), 1d-7, 'VPv correct')
  call assert_comparable(params( 6,2), 3.d0*ref_vsh(1), 1d-7, 'VSh correct')
  call assert_comparable(params( 7,2), 3.d0*ref_vsv(1), 1d-7, 'VSv correct')
  call assert_comparable(params( 8,2), 3.d0*ref_eta(1), 1d-7, 'Eta correct')
  call assert_comparable(params( 9,2), 3.d0*ref_phi(1), 1d-7, 'Phi correct')
  call assert_comparable(params(10,2), 3.d0*ref_xi(1),  1d-7, 'Xi correct')

end subroutine test_background_model_weight
!-----------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------
subroutine test_background_model_get_parameter_names()
  character(len=3)              :: parameter_names(12)
  character(len=3), parameter   :: parameter_names_ref(12) =            &
                                  ['vp ', 'vs ', 'rho', 'vph', 'vpv', 'vsh', &
                                   'vsv', 'eta', 'phi', 'xi ', 'lam', 'mu ']
  
  parameter_names = get_parameter_names()

  call assert_true(parameter_names==parameter_names_ref, 'Model parameter names are correct')

end subroutine test_background_model_get_parameter_names
!-----------------------------------------------------------------------------------------

end module test_background_model
!=========================================================================================
