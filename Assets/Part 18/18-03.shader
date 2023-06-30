Shader "Custom/18-03"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Noise ("Noise", 2D) = "black" {}
        _Cut ("NoiseCut", Range(0,1)) = 0.5
        _OutThickness("OutThickness", Range(1,1.5)) = 1.15
        [HDR]_OutColor("OutColor", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 200
        
        zwrite on
        ColorMask 0

        CGPROGRAM
        #pragma surface surf nolight noambient noforwardadd nolightmap novertexlights noshadow
        #pragma target 3.0

        struct Input
        {
            float4 color:COLOR;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
        }

        float4 Lightingnolight(SurfaceOutput s, float3 lightDir, float atten)
        {
            return float4 (0,0,0,0);
        }
        ENDCG
        
        zwrite off
        
        CGPROGRAM
        #pragma surface surf Lambert alpha:fade
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _Noise;
        float4 _OutColor;
        float _Cut;
        float _OutThickness;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_Noise;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;

            float4 noise = tex2D(_Noise, IN.uv_Noise);
            noise *= 20;

            if (noise.r >= _Cut)
                o.Alpha = 1;
            else
            {
                o.Alpha = 0;
            }

            float outline;
            if (noise.r >= _Cut*_OutThickness)
                outline = 0;
            else
            {
                outline = 1;
            }

            o.Emission = outline * _OutColor.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
