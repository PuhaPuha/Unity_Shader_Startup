Shader "Custom/12-02"
{
    Properties
    {
        _BumpMap("NormalMap", 2D) = "bump"{}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }

        CGPROGRAM
        #pragma surface surf nolight noambient alpha:fade

        #pragma target 3.0

        sampler2D _BumpMap;

        struct Input
        {
            float2 uv_BumpMap;
            float3 viewDir;
            float3 worldPos;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            float rim = saturate(dot(o.Normal, IN.viewDir));
            rim = pow(1-rim, 2);
            o.Emission = float3(0, 1, 0);
            o.Albedo = 0;
            o.Alpha = rim * abs(sin(_Time.y)) + pow(frac(IN.worldPos.g * 3 - _Time.y), 5) * 0.1;
            // o.Alpha = 1;
        }

        float4 Lightingnolight(SurfaceOutput s, float3 lightDir, float atten)
        {
            return float4(0,0,0,s.Alpha);
        }
        ENDCG
    }
    FallBack "Transparent/Diffuse"
}
