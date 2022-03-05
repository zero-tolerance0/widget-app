//
//  Response.swift
//  telemat
//
//  Created by didarmarat on 01.02.2022.
//

import Foundation

public struct TMResponse: Codable {
    let code: Int
    let result: TMValue
}

//struct MyResponse: Codable {
//    let quotes: [Quote]
//}

struct Response: Codable {
//    ["paginate": <null>, "result": {
//        calibrationMaxVal = 10;
//        calibrationMinVal = 0;
//        createdAt = "<null>";
//        deviceName = "\U0412\U0430\U0448 \U043e\U0431\U044a\U0435\U043a\U0442";
//        formatValue = "7,59";
//        id = 5;
//        lastValue =     {
//            createDate = "2022-01-28 16:52:49";
//            deviceId = 5;
//            formatDate = "28.01.2022 16:52:49";
//            id = 516046;
//            resultValue = "7.5926750503742";
//        };
//        notification =     (
//        );
//        paidDateTo = "2021-11-24 00:00:00";
//        paramName = "\U0412\U0430\U0448 \U043f\U0430\U0440\U0430\U043c\U0435\U0442\U0440";
//        sensorModeId = 3;
//        sensorTypeId = "<null>";
//        serialNumber = 2040077;
//        signalTypeId = 3;
//        sk0Name = "<null>";
//        sk1Name = "<null>";
//        status =     {
//            batteryStatusId = 1;
//            statusId = 5;
//        };
//        timezoneId = 4;
//        unitName = "\U0415\U0434. \U0438\U0437\U043c.";
//        updatedAt = "2022-01-28 07:30:42";
//        userId = 138087;
//        utcName = "GMT +05:00 \U0415\U043a\U0430\U0442\U0435\U0440\U0438\U043d\U0431\U0443\U0440\U0433";
//        utcZone = 5;
//    }, "code": 200, "message": <null>]
}
