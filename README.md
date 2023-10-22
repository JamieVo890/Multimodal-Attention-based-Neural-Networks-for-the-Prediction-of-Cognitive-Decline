# MNA-net: Multimodal Attention-Based Neural Networks for Prediction of Cognitive  Decline
## Paper
To be written

## Dataset
Image data was provided by OASIS3 from the Open Access Series of Imaging Studies (OASIS) (http://www.oasis-brains.org/). Image data is not uploaded to the repository as access needs to be requested.

## Requirements
Python 3.7.4 (and above)  
Pytorch 2.0
Further details on all packages used in this repository can be found in Requirements.txt

## Description
In this project, we present <b>MNA-net</b>, a mutimodal attention-based CNN for the prediction of mild cognitive impairment (MCI) and Alzheimer's Disease (AD) progression in cognitively normal (CN) individuals. This model combines both MRI and PET neuroimages using attention mechanisms and patch based techniques.
We define three stages in the classification process in MNA-net as shown in the figure below: 
  1. Patch feature extraction
  2. Multimodal attention
  3. Patch fusion
![MNA-net](https://github.com/JamieVo890/Multimodal-Attention-based-Neural-Networks-for-the-Prediction-of-Cognitive-Decline/assets/70950884/8658a856-293d-479b-b859-1a847c5c58fe)

<br>Due to the complexity and wideness of the architecture shown above, we train an individual model for each classification stage (patch feature extraction, multimodal attention, patch fusion). 
Features are extracted from each trained model and used as inputs for the subsequent classification stage. 

### Patch Feature Extraction
In the patch feature extraction stage, we first divide the MRI and PET images into 27 uniform patches. Each patch is then fed through a 3D ResNet-10 model to extract local features of each neuroimage. The 3D-ResNet code is adapted from https://github.com/kenshohara/3D-ResNets-PyTorch/tree/master.
![resnet](https://github.com/JamieVo890/Multimodal-Attention-based-Neural-Networks-for-the-Prediction-of-Cognitive-Decline/assets/70950884/de9d45c0-1998-4e86-9f44-b512247b95da) Once trained, the features from the dense layer prior to the final dense and sigmoid layers (coloured in blue in the figure above) are extracted and used in the next stage of the classification process, multimodal attention.

### Multimodal Attention
In the second stage of the classification process, we introduce an attention-based ensemble architecture to facilitate the fusion of the different neuroimaging modalities. For every patch in corresponding positions between the MRI and PET
patches, learnt features from the ResNet-10 models are extracted and passed through an attention-based model. This model utilises self-attention mechanisms to
enable the model to create shared representations of the MRI and PET features. Similar to the patch feature extraction stage, the features from the dense layer prior to the final dense and sigmoid layers are extracted and used in the final stage of the classification process, patch fusion.
![attention](https://github.com/JamieVo890/Multimodal-Attention-based-Neural-Networks-for-the-Prediction-of-Cognitive-Decline/assets/70950884/0e5a9a65-8c52-4129-8086-e601ed9a533a)

## Image Prepocessing
Post processed Freesurfer files for the MRI images were provided by OASIS-3. These files contain the subject-specific 3D MRI images which have undergone skull stripping. PIB PET images, however, were provided as 4D Nifti files. The PET images
were acquired in multiple frames over different time intervals post injection of the radiotracer (24 x 5 sec frames; 9 x 20 sec frames; 10 x 1 min frames; 9 x 5 min frames).
Temporal averaging of 4D PET images was performed to average the frames into
static 3D images. Noise and skull were removed from the PET images using Brain
Extration Tool (BET) and Synthstrip. Finally, both MRI and PET images were standardised and aligned to a common anatomical template by normalising voxel intensities
and registering them to Montreal Neurological Institute (MNI) space using FMRIB’s
Linear Image Registration Tool (FLIRT).

## Subject Selection
To predict the progression of cognitive impairment in individuals within OASIS-3,
two groups of subjects were of interest: subjects who remained CN, and subjects
transitioned from CN to MCI or AD over the course of the study in OASIS-3. For
this scope of this work, a timeframe 10 years was considered. A key factor to
consider during subject selection is the temporal alignment of data. It is important
that subject scans are taken within close proximity of their initial diagnosis to ensure
that scans are representative of their cognition at the time of their baseline. Taking
these factors into consideration, the subject selection criteria for the OASIS-3 dataset
were as follows:
  1. Subjects were diagnosed as CN at baseline.

  2. Subjects have taken MRI and PET scans that are within a year from their
  baseline diagnosis.

  3. Of CN subjects who developed cognitive impairment over the course of the
  study, only those who were diagnosed with MCI or AD within 10 years of
  their baseline diagnosis were considered.

  4. Of subjects who remained CN over the course of the study, only those who
  received a diagnosis of CN at least 10 years after their baseline diagnosis were
  considered.
