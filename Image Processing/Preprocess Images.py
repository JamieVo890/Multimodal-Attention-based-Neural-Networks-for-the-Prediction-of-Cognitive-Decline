import nibabel as nib
import numpy as np
from scipy.ndimage import gaussian_filter
import sys

def smooth_img(img,output_path,filename):
    sigma = 8 / (2.355 * 2.12)  # FWHM to sigma conversion
    smooth_data = gaussian_filter(img, sigma)
    smooth_img = nib.Nifti1Image(smooth_data, img.affine, img.header)
    nib.save(smooth_img, output_path + filename[36:-1])
    

def normalise_img(img,output_path,filename): 
        min_intensity = np.min(img)
        max_intensity = np.max(img)
    
        # Normalize the image intensities to the range [0, 1]
        normalised_data = (img - min_intensity) / (max_intensity - min_intensity)
        normalised_img = nib.Nifti1Image(normalised_data, img.affine, img.header)
        nib.save(normalised_img, output_path + filename[36:-1])
                

def main():
    args = sys.argv[1:]
    input_path = args[0]
    file_names_path = args[1]
    normalised_path = args[2]
    smoothed_path = args[3]
    
    # Loop through files in the directory
    f = open(file_names_path)

    # We only want to smooth the PET data
    if smoothed_path:
        for file in f:
            # Load the NIfTI file
            if file[2:-1] == "OAS30065_PIB_d0553/pet1/NIFTI/sub-OAS30065_ses-d0553_acq-PIB_pet.nii.gz": # Skip this one as it is a faulty file
                continue
            nifti_file = input_path + file[2:-1]
            
            img = nib.load(nifti_file)
            data = img.get_fdata()
            pet_data_3d = np.mean(data[:,:,:,-9:], axis=3)
            smooth_img(pet_data_3d,smoothed_path,file)
    
    # Normalise images
    for file in f:
        normalised_output_path = normalised_path + file[36:-1]
    
        # Load the NIfTI file
        if file[2:-1] == "OAS30065_PIB_d0553/pet1/NIFTI/sub-OAS30065_ses-d0553_acq-PIB_pet.nii.gz": # Skip this one as it is a faulty file
            continue
        nifti_file = smoothed_path + file[2:-1]
        img = nib.load(nifti_file)
        data = img.get_fdata()
        normalise_img(data,normalised_output_path,file)
        
if __name__ == '__main__':
    main()
    