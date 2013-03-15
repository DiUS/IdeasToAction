/*
       Licensed to the Apache Software Foundation (ASF) under one
       or more contributor license agreements.  See the NOTICE file
       distributed with this work for additional information
       regarding copyright ownership.  The ASF licenses this file
       to you under the Apache License, Version 2.0 (the
       "License"); you may not use this file except in compliance
       with the License.  You may obtain a copy of the License at

         http://www.apache.org/licenses/LICENSE-2.0

       Unless required by applicable law or agreed to in writing,
       software distributed under the License is distributed on an
       "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
       KIND, either express or implied.  See the License for the
       specific language governing permissions and limitations
       under the License.
 */

package com.ted.ideasintoaction;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import org.apache.cordova.*;

import com.zubhium.ZubhiumSDK;
import android.util.Log;

public class Actionman extends DroidGap
{
    ZubhiumSDK sdk;

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);

        // Show splash screen
        super.setIntegerProperty("splashscreen", R.drawable.splash);

        // Crash reporting
        String appVersion = "N/A";
        try
        {
            appVersion = this.getPackageManager().getPackageInfo(this.getPackageName(), 0).versionName;
        }
        catch (Exception e)
        {
            Log.v("onCreate", e.getMessage());
        }
        sdk = ZubhiumSDK.getZubhiumSDKInstance(getApplicationContext(), "14f186144b54a8b2ec77dac15e7ce4", appVersion);

        // Get arguments from the external url
        Intent intent = getIntent();
        String args = intent.getDataString();

        // Get the app going...
        if (args == null) {
          super.loadUrl("file:///android_asset/www/index.html", 4000);
        } else {
          String [] splitUrl = args.split("/");
          super.loadUrl("file:///android_asset/www/index.html#/ideas/" + splitUrl[splitUrl.length - 1]);
        }
    }
}

