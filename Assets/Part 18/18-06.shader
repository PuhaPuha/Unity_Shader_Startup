Shader "Custom/18-06"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        zwrite off

        GrabPass{}
        
        CGPROGRAM
        #pragma surface surf nolight noambient

        sampler2D _MainTex;
        sampler2D _GrabTexture;

        struct Input
        {
            float4 color:COLOR;
            float4 screenPos;
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            float4 c = tex2D (_MainTex, IN.uv_MainTex);
            float3 screenUV = IN.screenPos.rgb / IN.screenPos.a;
            o.Emission = tex2D(_GrabTexture,(screenUV.xy + c.x));
        }

        float4 Lightingnolight (SurfaceOutput s, float3 lightDir, float atten)
        {
            return float4(0,0,0,1);
        }
        ENDCG
    }
    FallBack "Regacy Shaders/Transparent/Vertexlit"
}
