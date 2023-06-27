Shader "Custom/default"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, float2(IN.uv_MainTex.x, IN.uv_MainTex.y + _Time.y) );
            o.Emission = float3(IN.uv_MainTex.x * _Time.y, IN.uv_MainTex.y * _Time.y, 0);
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
