# [EEE4165] 디지털영상처리개론

### HW0

**MATLAB 사용법 익히기**

### HW1

**Affine matrix를 통한 영상 처리 및 보간법 적용**

1. `Translate()`, `Rotate()` 함수 작성
2. `nearest-neighgor`와 `bicubic` 보간법을 구현함

### HW2

**Spatial domain에서의 영상 필터링**

1. Box filter, Sobel filter를 만들고 적용함
2. 이미지의 histogram을 분석하고, histogram equalization 수행하기

### HW3

**Fourier domain에서의 영상 필터링**

1. 영상의 Fourier spectrum과 phase를 추출하고, 이를 scale하여 보여주기
2. Fourier domain에서 다양한 크기의 box filter, gaussian filter를 적용하기

### HW4

**Non linear filtering / Notch filtering / Turbulence degradation**

1. Non linear filtering
   - Salt & pepper noise를 가하기
   - `Contraharmonic mean filter`, `Median filter`, `Adaptive median filter`를 구현하고 적용하기
2. Notch filtering
   - 주기적인 noise 가하기
   - Fourier domain에서 noise의 성분을 찾고 해당 부분만 추출해 noise 제거하기
3. Turbulence degradation과 이미지 복원
   - Turbulence degradation을 강도별로 가하기
   - K값을 조정하며 이미지 복원하기

### HW5

**컬러 이미지 처리**

1. 이미지에서 HSI space를 각각 분리하고, 마스킹하여 원하는 색상 분리하기
2. RGB space에서 원하는 색상 분리하기
