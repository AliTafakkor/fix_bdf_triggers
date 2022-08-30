import os
from scipy.io import loadmat


def load_subjects(results_path, subject_ids):
    subjects = list()
    for i, s in enumerate(subject_ids):
        subjects.append({})
        subject_path = os.path.join(results_path, 'S{:02d}'.format(s))
        found_files = os.listdir(subject_path)
        for file_name in found_files:
            if 'Familiarization' in file_name:
                file = loadmat(os.path.join(subject_path, file_name))
                subjects[i]['familiarization_exp'] = file['exp']
            if 'Recognition' in file_name:
                file = loadmat(os.path.join(subject_path, file_name))
                subjects[i]['recognition_exp'] = file['exp']
            if 'Imageability' in file_name:
                file = loadmat(os.path.join(subject_path, file_name))
                subjects[i]['imageability_exp'] = file['exp']
    return subjects
