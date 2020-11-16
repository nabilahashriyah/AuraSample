//
//  AlertLanguage.swift
//  Aura
//
//  Created by Stevhen on 03/11/20.
//

import Foundation

struct AlertLanguage {
    static func getData(language: String) -> [String]
    {
        if language == "0"
        {
           return [
            "Apakah kejang sudah berhenti?",
            "Jika kejang masih berlangsung, jangan keluar dari halaman ini.",
            "Belum",
            "Sudah",
            "Durasi Kejang", //4
            "Jika kejang terjadi lebih dari 5 menit,\nhubungi kontak darurat",
            "Kejang terjadi lebih dari 5 menit,\nsegera hubungi kontak darurat",
            "Selesai",
            "Darurat", //8
            "Mulai Pertolongan Pertama", //9
            "Hubungi kontak darurat atau temukan rumah sakit terdekat", //10
            "Rumah Sakit Terdekat", //11
            "Telepon Ambulans", //12
            "Apakah anda yakin ingin keluar dari langkah first aid?", //13
            "Tidak",
            "Ya"
           ]
        }
        else
        {
            return [
                "Has the seizure stopped?",
                "If it still occurs, please do not leave this page.",
                "Not yet",
                "Yes",
                "Seizure Duration",
                "If seizure lasts longer than 5 minutes,\ncall emergency",
                "Seizure occurs more than 5 minutes,\nplease contact emergency immediately.",
                "Done",
                "Emergency", //8
                "Start Assistance", //9
                "Call emergency contacts or find nearby hospital.",
                "Nearby Hospital",
                "Call Ambulance",
                "Are you sure you want to quit first aid steps?",
                "No",
                "Yes"
            ]
        }
    }
}
