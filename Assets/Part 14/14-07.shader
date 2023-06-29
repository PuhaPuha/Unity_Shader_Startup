Shader "Custom/14-07"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _RampTex ("RampTex", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf warp noambient
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _RampTex;

        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }

        float4 Lightingwarp(SurfaceOutput s, float3 lightDir, float3 viewDir, float atten)
        {
            float ndotl = dot(s.Normal,lightDir)*0.5+0.5;
            float4 ramp = tex2D(_RampTex, float2(viewDir.x, viewDir.y));
            return ramp;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
