using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Clock : MonoBehaviour
{
    const float hoursToDegrees = -30, minutesToDegrees = -6f, secondsToDegrees = -6f;
    
    [SerializeField]
	Transform hoursPivot, minutesPivot, secondsPivot;
    
    // Start is called before the first frame update
    void Update()
    {
        var timeDiscreet = DateTime.Now;    
        TimeSpan time = DateTime.Now.TimeOfDay;
        hoursPivot.localRotation = Quaternion.Euler(0, 0, hoursToDegrees * (float)time.TotalHours);
        minutesPivot.localRotation = Quaternion.Euler(0, 0, minutesToDegrees * (float)time.TotalMinutes);
        //secondsPivot.localRotation = Quaternion.Euler(0, 0, secondsToDegrees * (float)time.TotalSeconds);
        secondsPivot.localRotation = Quaternion.Euler(0, 0, secondsToDegrees * timeDiscreet.Second);
    }

}
